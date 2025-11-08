//
//  UserViewModel.swift
//  milestones
//
//  Created by Maryam Bahwal on 15/05/1447 AH.
//

import Foundation
import SwiftUI

class UserViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var selectedRoles: [String] = []
}
