//
//  ItemMarkerViewModel.swift
//  
//
//  Created by Alidin on 22/08/23.
//

import Foundation
import SwiftUI

class ItemMarkerViewModel : ObservableObject{
	@Published var isPopoverVisible = false
	@Published var isSheetVisible = false
	@Published var itemName = ""
	@Published var notes = ""
	@Published var labelId = ""
	@Published var dragOffset = CGSize.zero
	@Published var isDeleted = false
	
	@Published var label : ItemLabel?
	@Published var labelColor : Color?
	
	func deleteItem(item : Item, using presentationMode : Binding<PresentationMode>){
		_ = ItemService.shared.deleteItemByid(item.id)
		
		presentationMode.wrappedValue.dismiss()
		
		withAnimation {
			isDeleted.toggle()
		}
	}
	
	func saveItem(item : Binding<Item>, using presentationMode : Binding<PresentationMode>){
		item.wrappedValue.itemName = itemName
		item.wrappedValue.notes = notes
		item.wrappedValue.labelId = labelId
		
		label = ItemLabelService.shared.loadItemLabelById(id: labelId).data
		if let exsistedLabel = label{
			labelColor = Color(hex: exsistedLabel.labelColor)
		}
		
		_ = ItemService.shared.saveItem(item.wrappedValue)
		presentationMode.wrappedValue.dismiss()
	}
	
	func getLabel(){
		label = ItemLabelService.shared.loadItemLabelById(id: labelId).data
		
		if let exsistedLabel = label{
			labelColor = Color(hex: exsistedLabel.labelColor)
		}
	}
	
	
	func toggleEditMark(horizontalSizeClass : UserInterfaceSizeClass){
		if(horizontalSizeClass == .compact){
			isSheetVisible.toggle()
			
		}else{
			isPopoverVisible.toggle()
		}
		
	}
	
	func saveNewLocation(value : DragGesture.Value, imageSize : CGSize, item : Binding<Item>){
		let deltaX = value.translation.width
		let deltaY = value.translation.height
		let posX = item.x.wrappedValue * imageSize.width
		let posY = item.y.wrappedValue * imageSize.height
		
		let scaledNewPosX = (posX + deltaX) / imageSize.width
		let scaledNewPosY = (posY + deltaY) / imageSize.height
		
		item.x.wrappedValue = scaledNewPosX
		item.y.wrappedValue = scaledNewPosY
		
		_ = ItemService.shared.saveItem(item.wrappedValue)
		
		dragOffset = .zero
	}
	
	func populateInitialFormData(item : Item){
		itemName = item.itemName
		notes = item.notes
		labelId = item.labelId
		label = ItemLabelService.shared.loadItemLabelById(id: item.labelId).data
	}
	
	func changeItemLocation(value : DragGesture.Value, imageSize : CGSize){
		var newWidth = value.translation.width / (imageSize.width )
		var newHeight = value.translation.height / (imageSize.height )
		dragOffset = CGSize(width: newWidth , height: newHeight )
	}
}

