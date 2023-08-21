//
//  SwiftUIView.swift
//  
//
//  Created by Alidin on 17/04/23.
//

import SwiftUI
import UIKit

struct AddBagSheet: View {
	
	@State private var bagName: String = ""
	@State private var notes: String = ""
	@State private var image: UIImage? = nil
	@State private var showImagePicker: Bool = false
	@State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
	@State var isShowingActionSheet : Bool = false
	
	@EnvironmentObject var dataContainer : DataContainer
	@Environment(\.presentationMode) var presentationModel
	
	var body: some View {
		NavigationView {
			VStack( alignment : .leading, spacing: 16) {
				VStack(alignment: .leading, spacing : 8) {
					
					Text("Bag Name")
					TextField("Bag Name", text: $bagName)
						.primaryStyled()
					
				}
				
				VStack(alignment: .leading, spacing : 8) {
					Text("Notes (optional)")
					TextField("Notes", text: $notes)
						.primaryStyled()
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
				.background(AppColor.LIGHT_GRAY)
				.clipShape(RoundedRectangle(cornerRadius: 8))
				.overlay(
					RoundedRectangle(cornerRadius: 8)
						.stroke(AppColor.LIGHT_GRAY, lineWidth: 1) // Add a border with black color and width of 2
				)
				.onTapGesture {
					isShowingActionSheet = true
				}
				
			}
			.padding()
			.navigationBarTitle("Add Bag", displayMode: .inline)
			.navigationBarItems(
				leading:
					Button("Cancel") {
						presentationModel.wrappedValue.dismiss()
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
						presentationModel.wrappedValue.dismiss()
					}
					.disabled(
						bagName.isEmpty || image == nil
					)
					.foregroundColor(bagName.isEmpty || image == nil ? .gray : .teal)
				
			)
		}
		.sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
			ImagePickerController(image: $image, sourceType: sourceType)
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

