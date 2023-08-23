//
//  AddBagSheet.swift
//  
//
//  Created by Alidin on 17/04/23.
//

import SwiftUI
import UIKit

struct AddBagSheet: View {
	@EnvironmentObject var mainLayoutViewModel : MainLayoutViewModel
	
	@StateObject var addBagViewModel = AddBagViewModel()
	@Environment(\.presentationMode) var presentationModel
	
	var body: some View {
		NavigationView {
			VStack( alignment : .leading, spacing: 16) {
				VStack(alignment: .leading, spacing : 8) {
					
					Text("Bag Name")
					TextField("Bag Name", text: $addBagViewModel.bagName)
						.primaryStyled()
					
				}
				
				VStack(alignment: .leading, spacing : 8) {
					Text("Notes (optional)")
					TextField("Notes", text: $addBagViewModel.notes)
						.primaryStyled()
				}
				
				VStack{
					Spacer()
					if let image = addBagViewModel.image {
						
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
					addBagViewModel.isShowingActionSheet = true
				}
				
			}
			.padding()
			.navigationBarTitle("Add Bag", displayMode: .inline)
			.navigationBarItems(
				leading:
					Button("Cancel") {
						addBagViewModel.cancelSave()
						presentationModel.wrappedValue.dismiss()
					}
					.foregroundColor(.teal),
				
				trailing:
					Button("Save"){
						addBagViewModel.saveBag()
						mainLayoutViewModel.loadAllBag()
						presentationModel.wrappedValue.dismiss()
					}
					.disabled(
						addBagViewModel.bagName.isEmpty || addBagViewModel.image == nil
					)
					.foregroundColor(addBagViewModel.bagName.isEmpty || addBagViewModel.image == nil ? .gray : .teal)
				
			)
		}
		.sheet(isPresented: $addBagViewModel.showImagePicker, onDismiss: addBagViewModel.loadImage) {
			ImagePickerController(image: $addBagViewModel.image, sourceType: addBagViewModel.sourceType)
		}
		.actionSheet(isPresented: $addBagViewModel.isShowingActionSheet) {
			ActionSheet(
				title: Text("Import Image"),
				message: Text("Select image source"),
				buttons: [
					.default(Text("Camera"), action: {
						addBagViewModel.sourceType = .camera
						addBagViewModel.showImagePicker = true
						
						// Action for Button 1
					}),
					.default(Text("Library"), action: {
						addBagViewModel.sourceType = .photoLibrary
						addBagViewModel.showImagePicker = true
						// Action for Button 2
					}),
					.cancel(Text("Cancel"), action: {
						addBagViewModel.isShowingActionSheet = false
					}
							  
							 ) // Cancel button with red color
				]
			)
		}
	}
	
	
}

