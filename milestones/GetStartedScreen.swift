//
//  GetStartedScreen.swift
//  milestones
//
//  Created by Maryam Bahwal on 15/05/1447 AH.

import SwiftUI

// MARK: - Custom Capsule Button
struct ReusableCapsuleButton: View {
    let buttonText: String
    let action: () -> Void
    let textColor: Color
    let buttonColor: Color
    
    init(buttonText: String,
         action: @escaping () -> Void,
         textColor: Color = .black,
         buttonColor: Color = Color.white) {
        self.buttonText = buttonText
        self.action = action
        self.textColor = textColor
        self.buttonColor = buttonColor
    }
    
    var body: some View {
        Button(action: action) {
            Text(buttonText)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(textColor)
                .padding(.vertical, 15)
                .frame(maxWidth: .infinity)
                .background(buttonColor)
                .clipShape(Capsule())
                .shadow(radius: 5)
                .padding(.horizontal, 25)
        }
        .padding(.bottom, 30)
    }
}

// MARK: - Get Started Screen
struct GetStartedScreen: View {
    @EnvironmentObject var viewModel: ProjectViewModel
    @State private var showSignup = false
    
    var body: some View {
        ZStack {
            Image("Getstartedscreen")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                ReusableCapsuleButton(
                    buttonText: "Get Started",
                    action: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            showSignup = true
                        }
                    },
                    textColor: .black,
                    buttonColor: .white
                    
                )
                .padding(.bottom, 40)
            }
        }
        .fullScreenCover(isPresented: $showSignup) {
            OneLogin_1()
        }
    }
}


// MARK: - Preview
#Preview {
    GetStartedScreen()
    
}
