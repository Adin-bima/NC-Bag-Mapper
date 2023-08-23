//
//  UpdateBagViewModel.swift
//  
//
//  Created by Alidin on 22/08/23.
//

import SwiftUI

class UpdateBagViewModel : ObservableObject {
	@Published var bagName: String = ""
	@Published var notes: String = ""
	@Published var isShowingActionSheet : Bool = false
	
	func cancelUpdate(bag : Bag){
		bagName = bag.bagName
		notes = bag.notes
	}
	
	func saveBag(bag : Binding<Bag>){
		bag.wrappedValue.bagName = bagName
		bag.wrappedValue.notes = notes
		_ = BagService.shared.saveBag(bag.wrappedValue)
	}
}
