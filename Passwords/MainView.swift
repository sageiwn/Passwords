//
//  MainView.swift
//  Passwords
//
//  Created by Saglara Sandzhieva on 10/12/24.
//
import SwiftUI
struct MainView: View {
    @State private var searchText = ""
    @State private var isGenerateViewActive = false  // Состояние для активации NavigationLink
    let titles = ["All", "Private", "Deleted", "New Group"]
    let counts = ["0", "1", "2", "3"]
    let icons = ["key.fill", "lock.badge.clock.fill", "trash.fill", "plus.app.fill"]
    let colors = [Color.blue, Color.yellow, Color.orange, Color.green]
    
    var body: some View {
        NavigationStack {
            VStack {
                LazyVGrid(columns: [
                    GridItem(.flexible()), // Первый столбец
                    GridItem(.flexible())  // Второй столбец
                ], spacing: 16) {
                    ForEach(0..<titles.count, id: \.self) { index in
                        HStack {
                            VStack {
                                Text(titles[index])
                                
                                ZStack {
                                    Image(systemName: "circle.fill")
                                        .resizable()
                                        .foregroundColor(colors[index])
                                        .frame(width: 30, height: 30)
                                    
                                    Image(systemName: icons[index])
                                        .frame(width: 30, height: 30)
                                }
                            }
                            .padding()
                            Spacer()
                            
                            Text(counts[index])
                                .padding()
                        }
                        .frame(width: 200, height: 85)
                        .background(Color.white.opacity(0.6))
                        .shadow(radius: 10)
                        .cornerRadius(15)
                        .padding(8)
                    }
                }
                .padding(.top,-300) // Отступ сверху под строкой поиска
            }
            .navigationTitle("Passwords")
            .searchable(text: $searchText, prompt: "Search password")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Spacer()
                        Button(action: {
                            isGenerateViewActive.toggle()  // Активируем переход
                        }) {
                            HStack {
                                Image(systemName: "plus")
                              
                            }
                            .padding()
                            .foregroundColor(.blue)
                        }
                    }
                }
            }

            // NavigationLink для перехода на GenerateView
            NavigationLink(
                destination: PasswordGeneratorView(), // экран генерации пароля
                isActive: $isGenerateViewActive
            ) {
                EmptyView()
            }
        }
    }
}
