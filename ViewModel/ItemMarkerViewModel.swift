//
//  File.swift
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
	@Published var label : ItemLabel?
	@Published var dragOffset = CGSize.zero
	@Published var isDeleted = false
	
	func circleFill(item : Item)->Color{
		if item.label() != nil {
			return item.label()!.labelColor
		}
		return Color.gray
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
		item.wrappedValue.save()
		
		dragOffset = .zero
	}
}

