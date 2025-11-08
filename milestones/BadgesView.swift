//
//  BadgesView.swift
//  milestones
//
//  Created by Manar Majeed Alrasheed on 12/05/1447 AH.
//
import SwiftUI

struct Badge: Identifiable {
    let id = UUID()
    let title: String
    let emoji: String
    let isUnlocked: Bool
}

struct BadgesView: View {
    @EnvironmentObject var viewModel: ProjectViewModel
    @State private var selectedBadge: Badge? = nil
    @State private var showAlert = false

    let badges: [Badge] = [
        Badge(title: "First Milestone", emoji: "🚀", isUnlocked: true),
        Badge(title: "Ultimate Coder", emoji: "💻", isUnlocked: true),
        Badge(title: "Creative Spark", emoji: "🎨", isUnlocked: false),
        Badge(title: "App Pioneer", emoji: "📱", isUnlocked: false),
        Badge(title: "Insight Igniter", emoji: "💡", isUnlocked: false),
        Badge(title: "Rising Force", emoji: "🔥", isUnlocked: false),
        Badge(title: "Team Player", emoji: "🤝", isUnlocked: false),
        Badge(title: "Next Level", emoji: "🏆", isUnlocked: false),
        Badge(title: "Legacy Making", emoji: "🌟", isUnlocked: false)
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("Frame 77")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .offset(x: -110)
                    .ignoresSafeArea()
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 28) {
                        ForEach(badges) { badge in
                            Button {
                                selectedBadge = badge
                                withAnimation(.spring()) {
                                    showAlert = true
                                }
                            } label: {
                                VStack(spacing: 8) {
                                   
                                    Text(badge.isUnlocked ? badge.emoji : "🔒")
                                        .font(.system(size: 32))
                                        .opacity(badge.isUnlocked ? 1 : 0.4)
                                    
                                    
                                    if badge.isUnlocked {
                                        Text(badge.title)
                                            .font(.footnote)
                                            .foregroundColor(.white)
                                    }
                                }
                                .frame(width: 110, height: 110)
                                .background(
                                    badge.isUnlocked
                                    ? Color.white.opacity(0.01)
                                    : Color.black.opacity(0.3)
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(
                                            badge.isUnlocked
                                            ? Color.white.opacity(0.5)
                                            : Color.white.opacity(0.51),
                                            lineWidth: 1
                                        )
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.top, 30)
                    .padding(.horizontal, 20)
                }

                if showAlert, let badge = selectedBadge {
                    ZStack {
                        // Dim background behind alert
                        Color.black.opacity(0.4)
                            .ignoresSafeArea()
                            .onTapGesture {
                                withAnimation(.easeOut) {
                                    showAlert = false
                                }
                            }

                        VStack(spacing: 12) {
                            Text(badge.title)
                                .font(.headline)
                                .foregroundColor(.white)
                            Text(badge.isUnlocked ? "You’ve unlocked this badge! 🎉" : "This badge is locked 🔒")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                            
                            Button("OK") {
                                withAnimation(.easeOut) {
                                    showAlert = false
                                }
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 20)
                            .background(Color.white.opacity(0.15))
                            .clipShape(Capsule())
                        }
                        .padding(30)
                        .background(
                            Color.black.opacity(0.07)
                                .blur(radius: 0.05)
                                .background(.ultraThinMaterial)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.white.opacity(0.3), lineWidth: 1)
                        )
                        .shadow(radius: 10)
                        .padding(.horizontal, 40)
                    }
                    .transition(.opacity.combined(with: .scale))
                }
            }
            .navigationTitle("Badges")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    BadgesView()
        .environmentObject(ProjectViewModel())
}




