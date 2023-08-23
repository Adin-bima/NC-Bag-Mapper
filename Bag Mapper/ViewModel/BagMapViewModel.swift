//
//  BagMapViewModel.swift
//  
//
//  Created by Alidin on 21/08/23.
//

import Foundation
import SwiftUI

class BagMapViewModel : ObservableObject{
	@Published var scale: CGFloat = 1.0
	@Published var lastScale: CGFloat = 1.0
	@Published var position : CGPoint = .zero
	@Published var lastPosition : CGPoint = .zero
	@Published var initialImageSize : CGSize = .zero
	@Published var mainGeometrySize : CGSize = .zero
	@Published var isLegendOpened = false
	
	@Published var image : UIImage?
	@Published var imageSize : CGSize = .zero
	@Published var items : [Item] = []
	@Published var offset = CGSize.zero
	@Published var lastOffset = CGSize.zero
	@Published var focusedItemId = ""
	@Published var selectedLabel = ""
	@Published var deletedLabelId = ""

	func loadBagComponents(bagId : String){
		image = BagService.shared.getImage(bagId: bagId)
		if let itemsData = BagService.shared.loadItemsByBagId(bagId: bagId).data{
			items = itemsData
		}
	}
	
	func changeBagSelection(newBagValue : Bag){
		scale = 1.0
		lastScale = 1.0
		position  = .zero
		offset = .zero
		lastOffset = .zero
		lastPosition = .zero
	}
}
