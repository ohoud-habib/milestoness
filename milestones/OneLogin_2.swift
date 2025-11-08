//
//  OneLogin_2.swift
//  milestones
//
//  Created by Maryam Bahwal on 16/05/1447 AH.
//

import SwiftUI

struct OneLogin_2: View {
 
    @State private var isActive: Bool = false
    
    var body: some View {
        if isActive {
            SignUpScreen()
        } else {
            Image("OneLogin_2")
                .resizable()
                .ignoresSafeArea()
            
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            self.isActive = true
                        }
                    }
                }
        }
    }
}

