//
//  File.swift
//  
//
//  Created by Alidin on 22/08/23.
//

import Foundation

class UpdateBagViewModel : ObservableObject {
	@Published var bagName: String = ""
	@Published var notes: String = ""
	@Published var isShowingActionSheet : Bool = false
	
	func cancelUpdate(bag : Bag){
		bagName = bag.bagName
		notes = bag.notes
	}
	
	func saveBag(bag : Bag){
		bag.bagName = bagName
		bag.notes = notes
		bag.save()
	}
}
