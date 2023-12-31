//
//  ItemMarkerView.swift
//  
//
//  Created by Alidin on 19/04/23.
//

import SwiftUI

struct ItemMarkerView: View {
	@EnvironmentObject var mainLayoutViewModel : MainLayoutViewModel
	
	@Environment(\.horizontalSizeClass) var horizontalSizeClass
	@StateObject var itemMarkerViewModel = ItemMarkerViewModel()
	
	@Binding var item : Item
	@Binding var imageSize : CGSize
	@Binding var zoomScale : CGFloat
	@Binding var focusedItemId : String
	@Binding var deletedLabelId : String
	
	private var onFocused : (_ item : Item)-> Void
	
	init(item: Binding<Item>, imageSize: Binding<CGSize>, zoomScale : Binding<CGFloat>, focusedItemId : Binding<String>, deletedLabelId : Binding<String>, onFocused : @escaping (_ item : Item)->Void) {
		_item = item
		_imageSize = imageSize
		_focusedItemId = focusedItemId
		
		_zoomScale = zoomScale
		_deletedLabelId = deletedLabelId
		self.onFocused = onFocused
		
	}
	
	
	var body: some View {
		
		ZStack(){
			Circle()
				.fill( itemMarkerViewModel.labelColor != nil ? itemMarkerViewModel.labelColor!.opacity(focusedItemId == item.id ? 0.9 : 0.7 ) : Color.gray.opacity(focusedItemId == item.id ? 0.9 : 0.7 ))
				.overlay(
					Circle()
						.stroke(focusedItemId == item.id ? Color.white : Color.black.opacity(0.5) , lineWidth: 2) // Set stroke color and width of the circle
				)
				.contentShape(Circle())
			
			// MARK: POPOVER
				.popover(isPresented: $itemMarkerViewModel.isPopoverVisible, arrowEdge: .top) {
					UpdateMarkerSheet(
						itemMarkerViewModel : itemMarkerViewModel,
						item: $item,
						maxWidth : 320).environmentObject(mainLayoutViewModel)
					
				}
				.sheet(isPresented: $itemMarkerViewModel.isSheetVisible) {
					UpdateMarkerSheet(
						itemMarkerViewModel : itemMarkerViewModel,
						item: $item,
						maxWidth : .infinity)
					.presentationDetents([.height(360)])
				}
			
				.frame(width: 28 * (zoomScale < 1 ? 1 : 1/zoomScale), height: 28 * (zoomScale < 1 ? 1 : 1/zoomScale))
			
				.onTapGesture {
					
					onFocused(item)
					itemMarkerViewModel.toggleEditMark(horizontalSizeClass: horizontalSizeClass!)
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
					onFocused(item)
					itemMarkerViewModel.toggleEditMark(horizontalSizeClass: horizontalSizeClass!)	}
				.scaleEffect(zoomScale < 1 ? 1 : 1/zoomScale)
			
		}
		.position(x: item.x * imageSize.width , y: item.y * imageSize.height)
		.offset(CGSize(width: itemMarkerViewModel.dragOffset.width * imageSize.width, height:itemMarkerViewModel.dragOffset.height * imageSize.height  ))
		.gesture(
			DragGesture()
				.onChanged { value in
					itemMarkerViewModel.changeItemLocation(value : value, imageSize: imageSize)
				}
				.onEnded { value in
					itemMarkerViewModel.saveNewLocation(value: value, imageSize: imageSize, item: $item)
				}
		)
		.opacity(itemMarkerViewModel.isDeleted ? 0 : 1)
		.onChange(of: deletedLabelId) { newValue in
			if(newValue == itemMarkerViewModel.labelId){
				itemMarkerViewModel.labelId = ""
				itemMarkerViewModel.label = nil
			}
		}
		
		.onAppear(){
			itemMarkerViewModel.populateInitialFormData(item: item)
			itemMarkerViewModel.getLabel()
		}
		
	}
}

