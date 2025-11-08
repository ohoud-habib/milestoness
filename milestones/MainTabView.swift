//
//  MainTabView..swift
//  milestones
//
//  Created by Manar Majeed Alrasheed on 12/05/1447 AH.
//

import SwiftUI
import Combine

struct MainTabView: View {
    
    @StateObject var viewModel = ProjectViewModel()

    var body: some View {
        TabView {
            HomeView()
                .environmentObject(viewModel)
                .tabItem {
                    VStack {
                        Image("home_icon")
                            .renderingMode(.template)
                        Text("Home")
                    }
                }

            ConnectView()
                .tabItem {
                    VStack {
                        Image("connect_icon") 
                            .renderingMode(.template)
                        Text("Connect")
                    }
                }

            BadgesView()
                .tabItem {
                    VStack {
                        Image("badges_icon")
                            .renderingMode(.template)
                        Text("Badges")
                    }
                }

            ProfileView()
                .environmentObject(viewModel)
                .tabItem {
                    VStack {
                        Image("profile_icon")
                            .renderingMode(.template)
                        Text("Profile")
                    }
                }
        }
        .accentColor(Color("purplee"))
    }
}

#Preview {
    MainTabView()
        .environmentObject(ProjectViewModel())
}

