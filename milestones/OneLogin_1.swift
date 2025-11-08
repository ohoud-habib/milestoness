//
//  OneLogin_1.swift
//  milestones
//
//  Created by Maryam Bahwal on 16/05/1447 AH.
//

import SwiftUI

struct OneLogin_1: View {
  
    @State private var isActive: Bool = false
    
    var body: some View {
        if isActive {
            OneLogin_2()
        } else {
                Image("OneLogin_1")
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

