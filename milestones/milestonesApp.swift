//
//  milestonesApp.swift
//  milestones
//
//  Created by Manar Majeed Alrasheed on 12/05/1447 AH.
//

import SwiftUI
import Combine
@main
struct milestonesApp: App {
    @StateObject var viewModel = ProjectViewModel()
    @StateObject private var userVM = ProfileViewModel()
    
    var body: some Scene {
        WindowGroup {
            // Show SignUpScreen only if user hasn't completed sign-up
            if userVM.hasCompletedSignUp {
                MainTabView()
                    .preferredColorScheme(.dark)
                    .environmentObject(viewModel)
                    .environmentObject(userVM)
                    .environmentObject(ProjectViewModel())
            } else {
                SplashScreen()
                    .preferredColorScheme(.dark)
                    .environmentObject(viewModel)
                    .environmentObject(userVM)
                    .environmentObject(ProjectViewModel())
            }
        }
    }
}
