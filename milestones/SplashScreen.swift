//
//  SplashScreen.swift
//  milestones
//
//  Created by Maryam Bahwal on 15/05/1447 AH.

import SwiftUI

struct SplashScreen: View {
    @EnvironmentObject var viewModel: ProjectViewModel
    @State private var isActive: Bool = false
    
    var body: some View {
        if isActive {
            GetStartedScreen()
        } else {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreen()
    .environmentObject(ProjectViewModel())
}
