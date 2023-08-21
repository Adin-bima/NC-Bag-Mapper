//
//  SwiftUIView.swift
//  
//
//  Created by Alidin on 19/04/23.
//

import SwiftUI

struct ItemMarker: View {
	@Binding var item : Item
	@Binding var imageSize : CGSize
	@Binding var zoomScale : CGFloat
	@Binding var focusedItemId : String
	@Binding var deletedLabelId : String
	
	@EnvironmentObject var dataContainer : DataContainer
	
	@State private var isPopoverVisible = false
	@State private var itemName = ""
	@State private var notes = ""
	@State private var labelId = ""
	@State private var label : Label?
	
	@State private var dragOffset = CGSize.zero
	@State private var isDeleted = false
	
	private var onFocused : (_ item : Item)-> Void
	
	init(item: Binding<Item>, imageSize: Binding<CGSize>, zoomScale : Binding<CGFloat>, focusedItemId : Binding<String>, onFocused : @escaping (_ item : Item)->Void, deletedLabelId : Binding<String>) {
		_item = item
		_imageSize = imageSize
		_focusedItemId = focusedItemId
		_itemName = State(initialValue: item.wrappedValue.itemName)
		_notes = State(initialValue: item.wrappedValue.notes)
		_labelId = State(initialValue: item.wrappedValue.labelId)
		_label = State(initialValue: item.wrappedValue.label())
		_zoomScale = zoomScale
		self.onFocused = onFocused
		_deletedLabelId = deletedLabelId
	}
	
	@State var offset : CGSize = .zero
	

	var body: some View {
		let circleFillColor: Color = {
			
				if self.label != nil {
					return label!.labelColor
				} else {
					return Color.gray
				}
			
		}()
		
		ZStack(){
			Circle()
				.fill(circleFillColor.opacity(focusedItemId == item.id ? 0.9 : 0.7 ))
				.overlay(
					Circle()
						.stroke(focusedItemId == item.id ? Color.white : Color.black.opacity(0.5) , lineWidth: 2) // Set stroke color and width of the circle
				)
				.contentShape(Circle())
			
			// MARK: POPOVER
				.popover(isPresented: $isPopoverVisible, arrowEdge: .top) {
					VStack {
						TextField("Item name", text: $itemName)
							.textFieldStyle(.roundedBorder)
						TextField("Notes", text: $notes)
							.textFieldStyle(.roundedBorder)
						
						ScrollView(.horizontal, showsIndicators : false){
							HStack{
								ForEach(dataContainer.labels, id : \.id){
									label in
									HStack(spacing : 8){
										Circle()
											.fill(label.labelColor)
											.contentShape(Circle())
											.frame(width: 24, height: 24)
											.overlay(
												Circle()
													.stroke(labelId == label.id ? Color.white : Color.clear , lineWidth : 2)
											)
										
										Text(label.labelName)
											
									}
									
									.padding(8)
									.background( labelId == label.id ? label.labelColor.opacity(0.3) : Color.clear )
									.clipShape(
										Capsule()
									)
									.onTapGesture {
										if(labelId == label.id){
											labelId = ""
										}else{
											labelId = label.id
										}
									}
									.padding(1)
								}
								Spacer()
							}
							.frame(maxWidth: .infinity)
							
						}
						.frame(width: 200)
						
//						.frame(width: 120, height:32)
							
						
						HStack{
							Button(action: {
								item.delete()
								isPopoverVisible.toggle()
								withAnimation {
									isDeleted.toggle()
								}
							}) {
								Image(systemName: "trash")
							}.buttonStyle(BorderedButtonStyle())
							Spacer()
							Button(action: {
								item.itemName = itemName
								item.notes = notes
								item.labelId = labelId
								self.label = Label.load(id: labelId)
								item.save()
								isPopoverVisible.toggle()
							}) {
								Image(systemName: "checkmark")
							}.buttonStyle(BorderedProminentButtonStyle())
						}
					}
					.padding(16)
				}
			
				.frame(width: 28, height: 28)
				
				.onTapGesture {
					
					onFocused(item)
					isPopoverVisible.toggle()
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

