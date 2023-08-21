//
//  SwiftUIView.swift
//  
//
//  Created by Alidin on 17/04/23.
//

import SwiftUI
import UIKit

struct AddBagSheet: View {
	@Binding var isPresented: Bool
	@State private var bagName: String = ""
	@State private var notes: String = ""
	@State private var image: UIImage? = nil
	@State private var showImagePicker: Bool = false
	@State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
	@State var isShowingActionSheet : Bool = false
	
	@EnvironmentObject var dataContainer : DataContainer
	
	var body: some View {
		NavigationView {
			VStack( alignment : .leading, spacing: 16) {
				VStack(alignment: .leading, spacing : 8) {
					
					Text("Bag Name")
					TextField("Bag Name", text: $bagName)
						.padding(8)
						.background(Color(.systemBackground))
						.cornerRadius(8)
						.overlay(
							RoundedRectangle(cornerRadius: 8)
								.stroke(Color("lightGray"), lineWidth: 1) // Add a stroke with the primary color
						)
				}
				
				VStack(alignment: .leading, spacing : 8) {
					Text("Notes (optional)")
					TextField("Notes", text: $notes)
						.padding(8)
						.background(Color(.systemBackground))
						.cornerRadius(8)
						.overlay(
							RoundedRectangle(cornerRadius: 8)
								.stroke(Color("lightGray"), lineWidth: 1) // Add a stroke with the primary color
						)
				}
				
				VStack{
					Spacer()
					if let image = image {
						
						Image(uiImage: image)
							.resizable()
							.aspectRatio(contentMode: .fit)
							.clipShape(RoundedRectangle(cornerRadius: 8))
						
					}else{
						VStack{
							Image(systemName: "photo")
								.resizable()
								.scaledToFit()
								.frame(width: 40, height: 40)
								.foregroundColor(.gray)
							
							Text("Import image")
						}
					}
					Spacer()
					
				}
				.frame(maxWidth: .infinity)
				.background(Color("lightGray"))
				.clipShape(RoundedRectangle(cornerRadius: 8))
				.overlay(
					RoundedRectangle(cornerRadius: 8)
						.stroke(Color("lightGray"), lineWidth: 1) // Add a border with black color and width of 2
				)
				.onTapGesture {
					isShowingActionSheet = true
				}
				
				
//				Spacer()
//
//				HStack{
//					Button(action: {
//						isShowingActionSheet = true
//					}) {
//						Text("Import Image")
//							.foregroundColor(.white)
//							.padding()
//							.background(Color.teal)
//							.cornerRadius(8)
//							.padding(.horizontal)
//					}
//				}.frame(maxWidth: .infinity)
			}
			.padding()
			.navigationBarTitle("Add Bag", displayMode: .inline)
			.navigationBarItems(
				leading:
					Button("Cancel") {
						isPresented = false
					}
					.foregroundColor(.teal),
				
				trailing:
					Button("Save"){
						let newBag = Bag(id: UUID().uuidString, bagName: bagName, notes: notes)
						let saveImageResult = saveImageToLocalStorage(image: image!, id: newBag.id)

						if saveImageResult {
							newBag.save()
						}
						dataContainer.bags = Bag.loadAll()
						isPresented = false
					}
					.disabled(
						bagName.isEmpty || image == nil
					)
					.foregroundColor(bagName.isEmpty || image == nil ? .gray : .teal)
				
			)
		}
		.sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
			ImagePicker(image: $image, sourceType: sourceType)
		}
		.actionSheet(isPresented: $isShowingActionSheet) {
			ActionSheet(
				title: Text("Import Image"),
				message: Text("Select image source"),
				buttons: [
					.default(Text("Camera"), action: {
						sourceType = .camera
						showImagePicker = true
						
						// Action for Button 1
					}),
					.default(Text("Library"), action: {
						sourceType = .photoLibrary
						showImagePicker = true
						// Action for Button 2
					}),
					.cancel(Text("Cancel"), action: {
						isShowingActionSheet = false
					}
							  
							 ) // Cancel button with red color
				]
			)
		}
	}
	
	private func loadImage() {
		guard image != nil else { return }
	}
}

struct ImagePicker: UIViewControllerRepresentable {
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
		let parent: ImagePicker
		
		init(_ parent: ImagePicker) {
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
