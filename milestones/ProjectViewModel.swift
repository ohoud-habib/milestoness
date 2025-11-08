//
//  ProjectViewModel.swift
//  milestones
//
//  Created by Manar Majeed Alrasheed on 12/05/1447 AH.
//
import SwiftUI
import Combine

 class ProjectViewModel: ObservableObject {
    @Published var projects: [Project] = []
    // default init is synthesized, or you can add your own:
    init(projects: [Project] = []) {
        self.projects = projects
    }
}

