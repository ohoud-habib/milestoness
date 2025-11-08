//
//  ProfileView..swift
//  milestones
//
//  Created by Manar Majeed Alrasheed on 12/05/1447 AH.
//

import SwiftUI
import PhotosUI
import UIKit

// MARK: - Models

struct UserProfile: Identifiable {
    let id = UUID()
    var name: String
    var email: String
    var tags: [String]
    var image: UIImage?
}



final class ProfileViewModel: ObservableObject {
    // MARK: - User Session
    @Published var didLogout = false
    
    // MARK: - Basic User Info for Sign Up
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var selectedRoles: [String] = []
    
    // MARK: - Profile
    @Published var user: UserProfile = UserProfile(
        name: "Ghada Alsubaie",
        email: "OneLoginMail@examole.com",
        tags: ["UX/UI Design", "Marketing"],
        image: nil
    )
    
    // MARK: - Projects
    @Published var projects: [Project] = [
        Project(title: "Spark", category: "🚀 App Store Launch", image: UIImage(named: "spark") ?? UIImage()),
        Project(title: "Time Architect", category: "🎨 Design", image: UIImage(named: "time_architect") ?? UIImage()),
        Project(title: "Design Thinking", category: "🎤 Presenting", image: UIImage(named: "design_thinking") ?? UIImage())
    ]
    
    // MARK: - UI State
    @Published var showingSettings = false
    @Published var showingProfilePicturePicker = false
    @Published var showingShareSheet = false
    @Published var shareItems: [Any] = []
    
    // MARK: - Computed Full Name
    var fullName: String {
        let name = "\(firstName) \(lastName)".trimmingCharacters(in: .whitespaces)
        return name.isEmpty ? user.name : name
    }
    
    // MARK: - User Session
    @Published var hasCompletedSignUp: Bool = false // Add this
    
    // MARK: - User Defaults
    private let hasCompletedSignUpKey = "hasCompletedSignUp"
    
    init() {
        hasCompletedSignUp = UserDefaults.standard.bool(forKey: hasCompletedSignUpKey)
    }
    
    // MARK: - Helper Method
    func completeSignUp() {
        user.name = fullName
        user.tags = selectedRoles
        
        hasCompletedSignUp = true
        UserDefaults.standard.set(true, forKey: hasCompletedSignUpKey)
    }
    
    func logout() {
        hasCompletedSignUp = false
        UserDefaults.standard.set(false, forKey: hasCompletedSignUpKey)
        
        firstName = ""
        lastName = ""
        selectedRoles = []
        user.name = "Ghada Alsubaie"
        user.tags = ["UX/UI Design", "Marketing"]
        
        didLogout = true
    }
}

// MARK: - Helpers

func emojiToImage(emoji: String, size: CGFloat = 256) -> UIImage {
    let renderer = UIGraphicsImageRenderer(size: CGSize(width: size, height: size))
    return renderer.image { _ in
        UIColor.clear.setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 0, width: size, height: size)).fill()
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let font = UIFont.systemFont(ofSize: size * 0.6)
        let attrs: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: paragraph
        ]
        let attrString = NSAttributedString(string: emoji, attributes: attrs)
        let rect = CGRect(x: 0, y: (size - font.lineHeight) / 2.0, width: size, height: font.lineHeight)
        attrString.draw(in: rect)
    }
}

struct ActivityViewController: UIViewControllerRepresentable {
    let activityItems: [Any]
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

// MARK: - Main Profile View


struct ProfileView: View {
    @EnvironmentObject var viewModel: ProjectViewModel
    @EnvironmentObject var vm: ProfileViewModel
    var newProject: Project? = nil
    
    func tagColor(for tag: String) -> Color {
        switch tag {
        case "UX/UI Design":
            return Color.purple
        case "Marketing":
            return Color.cyan
        case "Back-End":
            return Color.green
        case "Business":
            return Color.orange
        default:
            return Color.gray
        }
    }
    
    var body: some View {
        
        
        NavigationStack {
            
            ZStack {
                Color.black.ignoresSafeArea()
                VStack(spacing: 0) {
                    header
                    
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                            ForEach(viewModel.projects) { project in
                                ProjectCard(project: project)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        vm.shareItems = [vm.user.name, vm.user.email]
                        vm.showingShareSheet = true
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.white)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        vm.showingSettings = true
                    } label: {
                        Image(systemName: "gearshape")
                            .foregroundColor(.white)
                    }
                }
            }
            
            .sheet(isPresented: $vm.showingSettings) {
                SettingsView()
                    .environmentObject(vm)
            }
            
            .sheet(isPresented: $vm.showingProfilePicturePicker) {
                ProfilePicturePickerView()
                    .environmentObject(vm)
            }
            .sheet(isPresented: $vm.showingShareSheet) {
                ActivityViewController(activityItems: vm.shareItems)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
        }
        .onAppear {
            if let project = newProject {
                vm.projects.append(project)
            }
        }
        
    }
    
    private var header: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 34, style: .continuous)
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color(red: 97/255, green: 46/255, blue: 177/255),                            Color(red: 15/255, green: 87/255, blue: 90/255),                              Color(red: 20/255, green: 40/255, blue: 50/255)]),
                        center: .topLeading,                        startRadius: 50,
                        endRadius: 400
                    )
                )
                .frame(height: 359)
                .frame(maxWidth: .infinity)
                .ignoresSafeArea(edges: .top)
                .offset(y: -36)
                .shadow(color: .black.opacity(0.4), radius: 8, x: 0, y: 6)
            
            
            
            VStack(spacing: 15) {
                ZStack(alignment: .bottomTrailing) {
                    Group {
                        if let ui = vm.user.image {
                            Image(uiImage: ui)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } else {
                            Image("profile_image")
                                .resizable()
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.white, .gray)
                                .aspectRatio(contentMode: .fill)
                            
                        }
                    }
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white.opacity(0.3), lineWidth: 3))
                    .shadow(radius: 10)
                    .onTapGesture {
                        vm.showingProfilePicturePicker = true
                    }
                    .padding(.top , 20)
                    
                    Button {
                        vm.showingProfilePicturePicker = true
                    } label: {
                        Circle()
                            .fill(Color.black.opacity(0.4))
                            .frame(width: 32, height: 32)
                            .overlay(
                                Image(systemName: "pencil")
                                    .foregroundColor(.white)
                                    .font(.system(size: 14))
                            )
                            .shadow(radius: 3)
                    }
                }
                
                HStack{
                    Text(vm.fullName)
                        .font(.title2.weight(.semibold))
                        .foregroundColor(.white)
                }
                
                Text("OneLoginMail@examole.com")
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.85))
                
                HStack(spacing: 8) {
                    ForEach(vm.user.tags, id: \.self) { tag in
                        Text(tag)
                            .font(.caption.weight(.semibold))
                            .padding(.vertical, 6)
                            .padding(.horizontal, 12)
                            .background(
                                Capsule()
                                    .fill(tagColor(for: tag))
                            )
                            .foregroundColor(.white)
                    }
                }
                .padding(.top, 6)
                
            }
        }
        .padding(.top, -70)
        
    }
    
}


// MARK: - ProjectCard View (Updated to use your Project model)

struct ProjectCard: View {
    let project: Project
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // project image
            Image(uiImage: project.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 100)
                .frame(width: 170)
                .clipped()
                .cornerRadius(12)
            
            // title
            Text(project.title)
                .font(.headline)
                .foregroundColor(.white)
            
            // category tag
            HStack {
                Text(project.category)
                    .font(.system(size: 12))
                    .padding(.vertical, 6)
                    .padding(.horizontal, 10)
                    .background(
                        Capsule()
                            .fill(Color.white.opacity(0.12))
                    )
                    .foregroundColor(.white)
            }
        }
        .padding(5)
        .background(Color.white.opacity(0.05))
        .cornerRadius(16)
    }
}

// MARK: - Settings View (bottom sheet)

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var vm: ProfileViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var editableName: String = ""
    @State private var selectedTags: Set<String> = []
    
    let allTags = ["UX/UI Design", "Marketing", "Back-End", "Business"]
    
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: Header
            
            VStack(spacing: 16) {
                
                // MARK: Top Bar
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color.gray.opacity(0.4))
                                .frame(width: 25, height: 25)
                            Image(systemName: "xmark")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.white)
                        }
                    }
                    
                    Spacer()
                    
                    Text("Profile")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    Button {
                        vm.user.name = editableName
                        vm.user.tags = Array(selectedTags)
                        
                        let nameComponents = editableName.split(separator: " ").map(String.init)
                        if nameComponents.count >= 2 {
                            vm.firstName = nameComponents[0]
                            vm.lastName = nameComponents[1...].joined(separator: " ")
                        } else if nameComponents.count == 1 {
                            vm.firstName = nameComponents[0]
                            vm.lastName = ""
                        }
                        
                        if !vm.hasCompletedSignUp {
                            vm.completeSignUp()
                        }
                        
                        dismiss()
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color.gray.opacity(0.4))
                                .frame(width: 25, height: 25)
                            Image(systemName: "checkmark")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                // MARK: Profile
                VStack(spacing: 8) {
                    if let ui = vm.user.image {
                        Image(uiImage: ui)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 90, height: 90)
                            .clipShape(Circle())
                            .shadow(radius: 8)
                    } else {
                        Image("profile_image")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 90, height: 90)
                            .clipShape(Circle())
                            .shadow(radius: 8)
                    }
                    
                    TextField("Name", text: $editableName)
                        .font(.title3.weight(.semibold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    Text(vm.user.email)
                        .font(.footnote)
                        .foregroundColor(.white.opacity(0.6))
                }
                
                // MARK: Tags
                HStack(spacing: 10) {
                    ForEach(allTags, id: \.self) { tag in
                        let isSelected = selectedTags.contains(tag)
                        Text(tag)
                            .font(.caption.weight(.semibold))
                            .padding(.vertical, 8)
                            .padding(.horizontal, 14)
                            .background(
                                Capsule()
                                    .fill(tagColor(for: tag)
                                        .opacity(isSelected ? 1.0 : 0.3))
                            )
                            .foregroundColor(.white)
                            .onTapGesture {
                                if isSelected {
                                    selectedTags.remove(tag)
                                } else {
                                    selectedTags.insert(tag)
                                }
                            }
                    }
                }
                .padding(.top, 10)
            }
            
            
            // MARK: Bottom Buttons
            VStack(spacing: 20) {
                Button {
                    vm.logout()
                    dismiss()
                } label: {
                    HStack {
                        Text("Log Out")
                        Spacer()
                        Image(systemName: "arrow.right.square")
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal)
                }
                
                
                Button(role: .destructive) {
                    vm.logout()
                    dismiss()
                } label: {
                    HStack {
                        Text("Delete Account")
                        Spacer()
                        Image(systemName: "trash")
                    }
                    .foregroundColor(.red)
                    .padding(.horizontal)
                }
                
                
                Spacer()
            }
            .padding(.top, 30)
        }
        .onAppear {
            editableName = vm.user.name
            selectedTags = Set(vm.user.tags)
        }
    }
    
    // MARK: Helper - Tag Colors
    func tagColor(for tag: String) -> Color {
        switch tag {
        case "UX/UI Design":
            return Color.purple
        case "Marketing":
            return Color.cyan
        case "Back-End":
            return Color.green
        case "Business":
            return Color.orange
        default:
            return Color.gray
        }
    }
}

// MARK: - Profile Picture Picker / Sticker Screen

struct ProfilePicturePickerView: View {
    @EnvironmentObject var vm: ProfileViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedUIImage: UIImage?
    
    // Some emoji stickers to choose from
    let stickers = [
        "🙂","😄","😉","🤗","🤩","🥳","😍","🤯","🤔","🤨","😭","😴","😇","🤒","😅","😳","🤭","👏"
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(spacing: 20) {
                        HStack {
                            Text("Stickers")
                                .font(.headline)
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 4), spacing: 12) {
                            ForEach(stickers, id: \.self) { s in
                                Button {
                                    let image = emojiToImage(emoji: s, size: 512)
                                    vm.user.image = image
                                    dismiss()
                                } label: {
                                    ZStack {
                                        Circle()
                                            .fill(Color(.systemGray6))
                                            .frame(height: 76)
                                        Text(s)
                                            .font(.system(size: 34))
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        Divider().padding(.vertical, 6)
                        
                        // Photos picker
                        VStack(spacing: 12) {
                            Text("Choose from Photos")
                                .font(.subheadline).bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                            
                            PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                                HStack {
                                    Image(systemName: "photo.on.rectangle.angled")
                                    Text("Pick a photo")
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                                .padding(.horizontal)
                            }
                            .onChange(of: selectedItem) { newItem in
                                Task {
                                    if let data = try? await newItem?.loadTransferable(type: Data.self),
                                       let ui = UIImage(data: data) {
                                        // assign cropped square version optionally
                                        let resized = ui.centerCroppedToSquare()?.scaled(to: 1024)
                                        vm.user.image = resized ?? ui
                                        dismiss()
                                    }
                                }
                            }
                        }
                        
                        Spacer(minLength: 40)
                    }
                }
            }
            .navigationTitle("Change Profile Picture")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}

// MARK: - UIImage helpers
extension UIImage {
    func centerCroppedToSquare() -> UIImage? {
        let originalSize = self.size
        let side = min(originalSize.width, originalSize.height)
        let cropRect = CGRect(x: (originalSize.width - side) / 2.0,
                              y: (originalSize.height - side) / 2.0,
                              width: side,
                              height: side)
        
        let format = UIGraphicsImageRendererFormat()
        format.scale = self.scale
        format.opaque = false
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: side, height: side), format: format)
        let img = renderer.image { _ in
            let drawOrigin = CGPoint(x: -cropRect.origin.x, y: -cropRect.origin.y)
            self.draw(at: drawOrigin)
        }
        return img
    }
    
    func scaled(to maxDimension: CGFloat) -> UIImage {
        let size = self.size
        let maxSide = max(size.width, size.height)
        guard maxSide > 0 else { return self }
        let ratio = min(maxDimension / maxSide, 1.0)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        
        let format = UIGraphicsImageRendererFormat()
        format.scale = self.scale
        format.opaque = false
        
        let renderer = UIGraphicsImageRenderer(size: newSize, format: format)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}


// MARK: - App / Preview
#if DEBUG
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(ProjectViewModel())  // ✅ Add this
            .environmentObject(ProfileViewModel())  // ✅ And this
            .preferredColorScheme(.dark)
    }
}
#endif


#Preview {
    ProfileView()
}
