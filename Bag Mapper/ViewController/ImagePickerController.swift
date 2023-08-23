//
//  ImagePickerController.swift
//  
//
//  Created by Alidin on 21/08/23.
//

import Foundation
import SwiftUI

struct ImagePickerController: UIViewControllerRepresentable {
	@Environment(\.presentationMode) private var presentationMode
	@Binding var image: UIImage?
	var sourceType: UIImagePickerController.SourceType = .photoLibrary
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	func makeUIViewController(context: Context) -> UIImagePickerController {
		let imagePicker = UIImagePickerController()
		imagePicker.sourceType = sourceType
		imagePicker.delegate = context.coordinator
		return imagePicker
	}
	
	func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
		
	}
	
	class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
		let parent: ImagePickerController
		
		init(_ parent: ImagePickerController) {
			self.parent = parent
		}
		
		func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
			if let selectedImage = info[.originalImage] as? UIImage {
				parent.image = selectedImage
			}
			parent.presentationMode.wrappedValue.dismiss()
		}
		
		func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
			parent.presentationMode.wrappedValue.dismiss()
		}
	}
}

