//
//  MainLayoutViewModel.swift
//  
//
//  Created by Alidin on 22/08/23.
//

import Foundation

class MainLayoutViewModel:ObservableObject{
	@Published var selectedBagId : String = ""
	@Published var isShowingAddBagModal = false
	@Published var bags : [Bag] = []
	@Published var labels : [ItemLabel] = []
	
	func loadAllBag(){
		if let bagsData = BagService.shared.loadBags().data{
			self.bags = bagsData.sorted(by: { b1, b2 in
				b1.isFavorite && !b2.isFavorite
			})
			
		}
		
	
	}
	
	func loadAllLabels(){
		if let labelsData = ItemLabelService.shared.LoadItemLabels().data{
			self.labels = labelsData
		}
	}
}
