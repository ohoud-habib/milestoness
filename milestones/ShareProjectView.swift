import SwiftUI
import PhotosUI
import UniformTypeIdentifiers
import UIKit
import Combine

struct ShareProjectView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: ProjectViewModel
  // @Environment(\.dismiss) var dismiss

    @State private var selectedImage: UIImage?
    @State private var showMenu = false
    @State private var showPhotoPicker = false
    @State private var showCamera = false
    @State private var showDocumentPicker = false
    @State private var selectedPhotoItem: PhotosPickerItem?

    @State private var projectTitle = ""
    @State private var selectedCategory: String?
    @State private var coOwners = ""

    let categories = [
        ("App Store Launch", "🚀"),
        ("Design Project", "🎨"),
        ("Code Project", "💻"),
        ("Case Study ", "🧾"),
        ("Presenting", "🎤"),
        ("Other", "⭐️")
    ]

    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 25) {
                    Text("Share a project")
                        .font(.title2.weight(.semibold))
                        .foregroundColor(.white)
                        .padding(.top, 20)

                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.windowBackground)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
                            )
                            .frame(width: 335,height: 150)
                            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)

                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 150)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .clipped()
                        } else {
                            VStack {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.system(size: 40))
                                    .foregroundColor(.white)
                                    .padding( 10)
                                Text("Capture your milestones!\nAdd a photo or a file to your project")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white.opacity(0.7))
                                    .multilineTextAlignment(.center)
                                    .font(.subheadline)
                            }
                        }
                    }
                    .onTapGesture {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                            showMenu.toggle()
                        }
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Project Title")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                         //   .font(.headline)
                        TextField("Project Title", text: $projectTitle)
                            .padding()
                           // .background(Color.white.opacity(0.15))
                            .frame(width: 335, height: 50)
                            .background( Color.black.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke( Color.white.opacity(0.1), lineWidth: 1)
                            )                            .foregroundColor(.white)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Category")
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                            .padding(.horizontal, 24)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(categories, id: \.0) { category in
                                    let isSelected = selectedCategory == category.0
                                    Button {
                                        selectedCategory = category.0
                                    } label: {
                                        VStack(spacing: 8) {
                                            Text(category.1)
                                                .font(.system(size: 32))
                                            Text(category.0)
                                                .font(.footnote)
                                                .foregroundColor(.white)
                                        }
                                        .frame(width: 100, height: 120)
                                        .background(isSelected ? Color.white.opacity(0.15) : Color.black.opacity(0.3))
                                        .clipShape(RoundedRectangle(cornerRadius: 16))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(isSelected ? Color.white.opacity(0.5) : Color.white.opacity(0.1), lineWidth: 1)
                                        )
                                    }
                                }
                            }
                            .padding(.horizontal, 4)
                        }
                    }

                    // 👥 Co-owners
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Co owners")
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                        TextField("galsubaie24@ twq.idserve.net", text: $coOwners)
                            .padding()
                            .frame(width: 335, height: 50)
                            .background( Color.black.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke( Color.white.opacity(0.1), lineWidth: 1)
                            )
                            .foregroundColor(.white)
                        
                        HStack {
                            Image(systemName: "info.circle")
                                .foregroundColor(.white.opacity(0.3))
                                .font(.system(size: 14))
                            Text("Mention co-owners academy email")
                                .foregroundColor(.white.opacity(0.3))
                                .font(.system(size: 14))
                            
                            
                        }
                    }
                    
                    .padding()

                    Button(action: {
                        if let selectedImage = selectedImage,
                           let selectedCategory = selectedCategory,
                           !projectTitle.isEmpty {

                            let newProject = Project(
                                title: projectTitle,
                                category: selectedCategory,
                                image: selectedImage
                            )

                            viewModel.projects.append(newProject)
                            dismiss()
                        }
                    }) {
                        VStack(spacing: 8) {
                            Text("Share")
                                .font(.headline)
                                .foregroundColor(.black)
                        }
                        .frame(width: 335, height: 50)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 49))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white.opacity(0.1), lineWidth: 1.9)
                        )
                    }

                    Spacer(minLength: 80)
                }
                .padding()
            }

            // قائمة الرفع
            if showMenu {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 0.2)) { showMenu = false }
                    }

                VStack(spacing: 0) {
                                 UploadMenuItem(title: "Photo Library", icon: "photo.on.rectangle") {
                                     showPhotoPicker = true
                                     showMenu = false
                                 }
                                 Divider().background(Color.white.opacity(0.15))
                                 UploadMenuItem(title: "Take Photo or Video", icon: "camera") {
                                     showCamera = true
                                     showMenu = false
                                 }
                                 Divider().background(Color.white.opacity(0.15))
                                 UploadMenuItem(title: "Browse", icon: "ellipsis.rectangle") {
                                     showDocumentPicker = true
                                     showMenu = false
                                 }
                             }
                             .frame(width: 270)
                             .background(.ultraThinMaterial)
                             .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                             .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color.white.opacity(0.25)))
                             .shadow(color: .black.opacity(0.5), radius: 20, x: 0, y: 10)
                             .transition(.scale.combined(with: .opacity))
                             .offset(x:-30,y: -75)
            }
        }
        // Pickers
        .photosPicker(isPresented: $showPhotoPicker, selection: $selectedPhotoItem)
        .sheet(isPresented: $showCamera) {
            ImagePicker(sourceType: .camera, selectedImage: $selectedImage)
        }
        .sheet(isPresented: $showDocumentPicker) {
            DocumentPicker()
        }
        .onChange(of: selectedPhotoItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    selectedImage = uiImage
                }
            }
        }
    }
}

// MARK: - Upload Menu Item
struct UploadMenuItem: View {
    var title: String
    var icon: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundColor(.white)
                    .font(.system(size: 18))
                    .frame(width: 26)
                Text(title)
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .medium))
                Spacer()
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 12)
            .background(Color.white.opacity(0.01))
        }
    }
}

#Preview {
    ShareProjectView()
}

