//
//  Untitled.swift
//  milestones1
//
//  Created by ohoud on 15/05/1447 AH.
//

import SwiftUI
import PhotosUI
import UniformTypeIdentifiers
import UIKit
import Combine

struct ImagePicker: UIViewControllerRepresentable {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        init(_ parent: ImagePicker) { self.parent = parent }
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true)
        }
    }

    var sourceType: UIImagePickerController.SourceType
    @Binding var selectedImage: UIImage?

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

struct DocumentPicker: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        UIDocumentPickerViewController(forOpeningContentTypes: [UTType.content, UTType.image, UTType.pdf])
    }
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
}
