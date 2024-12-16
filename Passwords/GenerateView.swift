//
//  GenerateView.swift
//  Passwords
//
//  Created by Saglara Sandzhieva on 10/12/24.
//
import SwiftUI

struct PasswordGeneratorView: View {
    @State private var passwordLength: String = ""
    @State private var includeUppercase: Bool = false
    @State private var includeLowercase: Bool = false
    @State private var includeNumbers: Bool = false
    @State private var includeSymbols: Bool = false
    @State private var generatedPassword: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Password Options")) {
                HStack {
                    Text("Length")
                    Spacer()
                    TextField("Enter length", text: $passwordLength)
                        .frame(width: 60, height: 40)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing)
                }
                
                Toggle("Capital letters", isOn: $includeUppercase)
                Toggle("Lowercase Letters", isOn: $includeLowercase)
                Toggle("Digits", isOn: $includeNumbers)
                Toggle("Symbols (?!@:+)", isOn: $includeSymbols)
            }
            
            Section {
                Button(action: {
                    generatePassword()
                }) {
                    Text("Generate")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .listRowBackground(Color.clear)
            }
            
            if !generatedPassword.isEmpty {
                Section(header: Text("Generated Password")) {
                    HStack {
                        Text(generatedPassword)
                            .font(.body.monospaced())
                            .foregroundColor(.gray)
                            .padding(.vertical)
                        Spacer()
                        Button(action: {
                            UIPasteboard.general.string = generatedPassword
                        }) {
                            Image(systemName: "doc.on.clipboard")
                                .foregroundColor(.blue)
                        }
                        .padding(.trailing)
                    }
                }
            }
        }
        .navigationTitle("Password Generator")
    }
    
    private func generatePassword() {
        // Проверка корректности введенной длины пароля
        guard let length = Int(passwordLength), length > 0 else {
            generatedPassword = "Please enter a valid length."
            return
        }

        var characterPool = ""
        
        // Добавление символов в пул, в зависимости от выбора пользователя
        if includeUppercase { characterPool += "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
        if includeLowercase { characterPool += "abcdefghijklmnopqrstuvwxyz" }
        if includeNumbers { characterPool += "0123456789" }
        if includeSymbols { characterPool += "!@#$%^&*()_+-=[]{}|;:,.<>?" }

        // Проверка на наличие хотя бы одного типа символов
        guard !characterPool.isEmpty else {
            generatedPassword = "Please select at least one character type."
            return
        }

        // Генерация пароля
        generatedPassword = String((0..<length).compactMap { _ in characterPool.randomElement() })
    }
}

struct PasswordGeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PasswordGeneratorView()
        }
    }
}
