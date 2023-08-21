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
	
	@Binding var itemName : String
	@Binding var notes : String
	@Binding var labelId : String
	@Binding var item : Item
	@Binding var isDeleted : Bool
	@Binding var label : Label?
	
	
    var body: some View {
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
					
					presentationModel.wrappedValue.dismiss()
					
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
					label = Label.load(id: labelId)
					item.save()
					
					presentationModel.wrappedValue.dismiss()
				}) {
					Image(systemName: "checkmark")
				}.buttonStyle(BorderedProminentButtonStyle())
			}
		}
		.padding(16)
    }
}

