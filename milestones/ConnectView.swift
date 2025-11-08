//
//  Untitled.swift
//  milestones
//
//  Created by Manar Majeed Alrasheed on 12/05/1447 AH.
//

import SwiftUI

struct ConnectView: View {
    @EnvironmentObject var viewModel: ProjectViewModel
    @State private var searchText = ""
    
    // Example friends list
    let friends = [
        "Sarah", "Omar", "Mona", "Ali", "Rania", "Laila", "Hassan"
    ]
    
    var filteredFriends: [String] {
        if searchText.isEmpty {
            return []
        } else {
            return friends.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                Image("Screen Content")
                
                if filteredFriends.isEmpty && searchText.isEmpty {
                    // 🪄 Empty state (like your screenshot)
                   
                    
                } else {
                    // 🧑‍🤝‍🧑 Show search results
                    List(filteredFriends, id: \.self) { friend in
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 32))
                                .foregroundColor(.white.opacity(0.8))
                            Text(friend)
                                .foregroundColor(.white)
                        }
                        .listRowBackground(Color.black.opacity(0.3))
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                }
            }
            .navigationTitle("Connect")
            .searchable(text: $searchText, prompt: "Search")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    ConnectView()
        .environmentObject(ProjectViewModel())
}

