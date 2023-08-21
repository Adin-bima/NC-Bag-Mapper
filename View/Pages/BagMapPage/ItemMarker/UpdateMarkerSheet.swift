//
//  SwiftUIView.swift
//  
//
//  Created by Alidin on 21/08/23.
//

import SwiftUI

struct UpdateMarkerSheet: View {
	@EnvironmentObject var dataContainer : DataContainer
	@Environment(\.presentationMode) var presentationModel
	@Environment(\.horizontalSizeClass) var horizontalSizeClass
	
	@Binding var itemName : String
	@Binding var notes : String
	@Binding var labelId : String
	@Binding var item : Item
	@Binding var isDeleted : Bool
	@Binding var label : ItemLabel?
	
	var maxWidth : CGFloat
	
	func saveItem(){
		item.delete()
		
		presentationModel.wrappedValue.dismiss()
		
		withAnimation {
			isDeleted.toggle()
		}
	}
	
	
	func deleteItem(){
		item.itemName = itemName
		item.notes = notes
		item.labelId = labelId
		label = ItemLabel.load(id: labelId)
		item.save()
		
		presentationModel.wrappedValue.dismiss()
	}
	
	
	var body: some View {
		VStack (alignment : .leading) {
			Text("Item name")
			TextField("Item name", text: $itemName)
				.textFieldStyle(.roundedBorder)
				.padding(.bottom, 8)
			
			Text("Note (Optional)")
			TextField("Notes", text: $notes)
				.textFieldStyle(.roundedBorder)
				.padding(.bottom, 8)
			
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
					
				}
				
				
			}
//
			
			
			HStack{
				Button(action: saveItem) {
					Image(systemName: "trash")
						.padding(8)
				}.buttonStyle(BorderedButtonStyle())
				
				Spacer()
				
				Button(action: deleteItem) {
					Image(systemName: "checkmark")
						.padding(8)
				}.buttonStyle(BorderedProminentButtonStyle())
			}
		}
		.frame(maxWidth: maxWidth)
		.padding(24)
	}
}

