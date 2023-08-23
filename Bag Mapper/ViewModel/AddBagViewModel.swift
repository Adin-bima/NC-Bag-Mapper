//
//  AddBagViewModel.swift
//  
//
//  Created by Alidin on 22/08/23.
//

import Foundation
import SwiftUI

class AddBagViewModel : ObservableObject {
	@Published var bagName: String = ""
	@Published var notes: String = ""
	@Published var image: UIImage? = nil
	@Published var showImagePicker: Bool = false
	@Published var sourceType: UIImagePickerController.SourceType = .photoLibrary
	@Published var isShowingActionSheet : Bool = false
	@Published var bags : [Bag] = []
	
	func loadImage() {
		guard image != nil else { return }
	}
	
	func cancelSave(){
		bagName = ""
		notes = ""
	}
	
	func saveBag(){
		let newBag = Bag(id: UUID().uuidString, bagName: bagName, notes: notes)
		let saveImageResult = saveImageToLocalStorage(image: image!, id: newBag.id)
		
		if saveImageResult {
			_ = BagService.shared.saveBag(newBag)
		}
		
		bags.append(newBag)
	}
}
