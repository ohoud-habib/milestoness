//
//  Project.swift
//  milestones
//
//  Created by Manar Majeed Alrasheed on 12/05/1447 AH.
//import SwiftUI

import SwiftUI
import UIKit

struct Project: Identifiable {
    let id = UUID()
    let title: String
    let category: String
    let image: UIImage
}

