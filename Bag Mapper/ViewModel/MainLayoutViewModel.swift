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
			bags = bagsData
		}
	}
	
	func loadAllLabels(){
		if let labelsData = ItemLabelService.shared.LoadItemLabels().data{
			labels = labelsData
		}
	}
}
