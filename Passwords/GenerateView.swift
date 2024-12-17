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
    @State private var savedPasswords: [PasswordItem] = [] // Хранилище для сохранённых паролей
    @State private var showCopiedAlert: Bool = false // Для отображения уведомления при копировании
    @State private var selectedCategory: String = "All" // Категория, выбранная пользователем
    @State private var siteName: String = "" // Поле для названия сайта
    @State private var notes: String = "" // Поле для заметок
    
    
    let categories = ["All", "Private", "Deleted", "New Group"] // Возможные категории для паролей

    var body: some View {
        Form {
            Section(header: Text("Password Options")) {
                HStack {
                    Text("Length")
                    Spacer()
                    TextField("", text: $passwordLength)
                        .frame(width: 60, height: 40)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                }
                
                Toggle("Capital letters", isOn: $includeUppercase)
                Toggle("Lowercase Letters", isOn: $includeLowercase)
                Toggle("Digits", isOn: $includeNumbers)
                Toggle("Symbols (?!@:+)", isOn: $includeSymbols)
            }
            
            Section(header: Text("Category")) {
                Picker("Select Category", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { category in
                        Text(category)
                    }
                }
                .pickerStyle(MenuPickerStyle())
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
                            .padding(.trailing, 8)
                        
                        Spacer()
                        
                        Button(action: {
                            copyToClipboard()
                        }) {
                            Image(systemName: "doc.on.doc")
                                .foregroundColor(.blue)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .navigationTitle("Password Generator")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    savePassword()
                }
                .disabled(generatedPassword.isEmpty) // Блокируем кнопку, если пароля нет
            }
        }
        .alert("Password copied to clipboard!", isPresented: $showCopiedAlert) {
            Button("OK", role: .cancel) {}
        }
    }
    
    // Логика генерации пароля
    private func generatePassword() {
        guard let length = Int(passwordLength), length > 0 else {
            generatedPassword = "Please enter a valid length."
            return
        }

        var characterPool = ""
        if includeUppercase {
            characterPool += "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        }
        if includeLowercase {
            characterPool += "abcdefghijklmnopqrstuvwxyz"
        }
        if includeNumbers {
            characterPool += "0123456789"
        }
        if includeSymbols {
            characterPool += "!@#$%^&*()_+-=[]{}|;:,.<>?"
        }

        guard !characterPool.isEmpty else {
            generatedPassword = "Please select at least one character type."
            return
        }

        generatedPassword = String((0..<length).compactMap { _ in characterPool.randomElement() })
    }

    // Логика сохранения пароля
    private func savePassword() {
        let newPassword = PasswordItem(password: generatedPassword, category: selectedCategory, siteName: siteName, notes: notes)// Сохраняем с выбранной категорией
        savedPasswords.append(newPassword)
        print("Saved passwords: \(savedPasswords)") // Для проверки сохраняем в консоль
    }
    
    // Логика копирования пароля в буфер обмена
    private func copyToClipboard() {
        UIPasteboard.general.string = generatedPassword
        showCopiedAlert = true // Показываем уведомление
    }
}

struct PasswordGeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PasswordGeneratorView()
        }
    }
}
