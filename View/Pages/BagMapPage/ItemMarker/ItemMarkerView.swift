//
//  SwiftUIView.swift
//  
//
//  Created by Alidin on 19/04/23.
//

import SwiftUI

struct ItemMarkerView: View {
	@Binding var item : Item
	@Binding var imageSize : CGSize
	@Binding var zoomScale : CGFloat
	@Binding var focusedItemId : String
	@Binding var deletedLabelId : String
	
	@EnvironmentObject var dataContainer : DataContainer
	@Environment(\.horizontalSizeClass) var horizontalSizeClass
	
	@State private var isPopoverVisible = false
	@State private var isSheetVisible = false
	@State private var itemName = ""
	@State private var notes = ""
	@State private var labelId = ""
	@State private var label : ItemLabel?
	@State private var dragOffset = CGSize.zero
	@State private var isDeleted = false
	
	private var onFocused : (_ item : Item)-> Void
	
	init(item: Binding<Item>, imageSize: Binding<CGSize>, zoomScale : Binding<CGFloat>, focusedItemId : Binding<String>, deletedLabelId : Binding<String>, onFocused : @escaping (_ item : Item)->Void) {
		_item = item
		_imageSize = imageSize
		_focusedItemId = focusedItemId
		_itemName = State(initialValue: item.wrappedValue.itemName)
		_notes = State(initialValue: item.wrappedValue.notes)
		_labelId = State(initialValue: item.wrappedValue.labelId)
		_label = State(initialValue: item.wrappedValue.label())
		_zoomScale = zoomScale
		_deletedLabelId = deletedLabelId
		self.onFocused = onFocused
	}
	
	func circleFill()->Color{
		if self.label != nil {
			return label!.labelColor
		}
		return Color.gray
	}
	
	func toggleEditMark(){
		if(horizontalSizeClass == .compact){
			isSheetVisible.toggle()
			
		}else{
			isPopoverVisible.toggle()
		}
		
	}
	
	
	var body: some View {
		
		ZStack(){
			Circle()
				.fill(circleFill().opacity(focusedItemId == item.id ? 0.9 : 0.7 ))
				.overlay(
					Circle()
						.stroke(focusedItemId == item.id ? Color.white : Color.black.opacity(0.5) , lineWidth: 2) // Set stroke color and width of the circle
				)
				.contentShape(Circle())
			
			// MARK: POPOVER
				.popover(isPresented: $isPopoverVisible, arrowEdge: .top) {
					UpdateMarkerSheet(itemName: $itemName, notes: $notes, labelId: $labelId, item: $item, isDeleted: $isDeleted, label: $label, maxWidth : 320)
				}
				
			
				.sheet(isPresented: $isSheetVisible) {
					UpdateMarkerSheet(itemName: $itemName, notes: $notes, labelId: $labelId, item: $item, isDeleted: $isDeleted, label: $label, maxWidth : .infinity)
						.presentationDetents([.height(320)])
				}
			
				.frame(width: 28, height: 28)
			
				.onTapGesture {
					
					onFocused(item)
					
					toggleEditMark()
					
				}
			
			
			Text("\(item.itemName)")
				.frame(height: 16)
				.foregroundColor(Color.black)
				.padding(6)
				.background(
					RoundedRectangle(cornerRadius: 8)
						.fill(Color.white.opacity(0.8))
				)
				.offset(CGSize(width: 0, height: 32))
				.onTapGesture {
					isPopoverVisible.toggle()
				}
		}
		.position(x: item.x * imageSize.width , y: item.y * imageSize.height)
		.offset(CGSize(width: dragOffset.width * imageSize.width, height: dragOffset.height * imageSize.height  ))
		.gesture(
			DragGesture()
				.onChanged { value in
					
					dragOffset = CGSize(width: value.translation.width / (imageSize.width ), height: value.translation.height / (imageSize.height ))
				}
			
				.onEnded { value in
					let deltaX = value.translation.width
					let deltaY = value.translation.height
					let posX = item.x * imageSize.width
					let posY = item.y * imageSize.height
					
					let scaledNewPosX = (posX + deltaX) / imageSize.width
					let scaledNewPosY = (posY + deltaY) / imageSize.height
					
					item.x = scaledNewPosX
					item.y = scaledNewPosY
					item.save()
					
					dragOffset = .zero
				}
		)
		.opacity(isDeleted ? 0 : 1)
		.onChange(of: deletedLabelId) { newValue in
			if(newValue == labelId){
				labelId = ""
				label = nil
			}
		}
		
	}
}

