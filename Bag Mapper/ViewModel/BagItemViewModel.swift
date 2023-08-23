//
//  BagItemViewModel.swift
//  
//
//  Created by Alidin on 23/08/23.
//

import SwiftUI

class BagItemViewModel : ObservableObject{
	@Published var isDeleting : Bool = false
	@Published var isUpdating : Bool = false
	
	func toggleFavorite(bag : Binding<Bag>){
		bag.isFavorite.wrappedValue.toggle()
		_ = BagService.shared.saveBag(bag.wrappedValue)
	}
	
	func deleteBag(bag : Binding<Bag>){
		_ = BagService.shared.deleteBagById(bag.id)
	}
	
}
