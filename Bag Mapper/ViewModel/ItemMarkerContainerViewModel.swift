//
//  ItemMarkerContainerViewModel.swift
//  
//
//  Created by Alidin on 23/08/23.
//

import SwiftUI

class ItemMarkerContainerViewModel : ObservableObject{
	func createNewItem(location : CGPoint, geo : GeometryProxy, bagMapViewModel : BagMapViewModel, bagId : String){
		if(bagMapViewModel.isLegendOpened){
			withAnimation {
				bagMapViewModel.isLegendOpened.toggle()
			}
		}else{
			var newItem = Item(
				id: UUID().uuidString,
				bagId: bagId,
				itemName: "New item",
				notes: "",
				x: location.x / geo.size.width,
				y: location.y / geo.size.height
			)
			newItem.labelId = bagMapViewModel.selectedLabel
			
			_ = ItemService.shared.saveItem(newItem)
			bagMapViewModel.items.append(newItem)
		}
	}
}
