//
//  UpdateMarkerSheet.swift
//  
//
//  Created by Alidin on 21/08/23.
//

import SwiftUI

struct UpdateMarkerSheet: View {
	@EnvironmentObject var mainLayoutViewModel : MainLayoutViewModel
	
	@Environment(\.presentationMode) var presentationMode
	@Environment(\.horizontalSizeClass) var horizontalSizeClass
	
	@ObservedObject var itemMarkerViewModel : ItemMarkerViewModel
	@Binding var item : Item
	
	var maxWidth : CGFloat
	
	var body: some View {
		VStack (alignment : .leading) {
			Text("Item name")
			TextField("Item name", text: $itemMarkerViewModel.itemName)
				.textFieldStyle(.roundedBorder)
				.padding(.bottom, 8)
			
			Text("Note (Optional)")
			TextField("Notes", text: $itemMarkerViewModel.notes)
				.textFieldStyle(.roundedBorder)
				.padding(.bottom, 8)
			
			ScrollView(.horizontal, showsIndicators : false){
				HStack{
					ForEach($mainLayoutViewModel.labels, id : \.id){
						$label in
						HStack(spacing : 8){
							Circle()
								.fill(Color(hex : label.labelColor))
								.contentShape(Circle())
								.frame(width: 24, height: 24)
								.overlay(
									Circle()
										.stroke(item.labelId == label.id ? Color.white : Color.clear , lineWidth : 2)
								)
							
							Text(label.labelName)
							
						}
						
						.padding(8)
						.background( item.labelId == label.id ? Color(hex : label.labelColor).opacity(0.3) : Color.clear )
						.clipShape(
							Capsule()
						)
						.onTapGesture {
							if(item.labelId == label.id){
								item.labelId = ""
								itemMarkerViewModel.labelId = ""
							}else{
								item.labelId = label.id
								itemMarkerViewModel.labelId = label.id
							}
						}
						.padding(1)
					}
					
				}
				
			}
			
			
			HStack{
				Button(){
					itemMarkerViewModel.deleteItem(item: item, using: presentationMode)
				}label: {
					Image(systemName: "trash")
						.padding(8)
				}.buttonStyle(BorderedButtonStyle())
				
				Spacer()
				
				Button(){
					itemMarkerViewModel.saveItem(item: $item, using: presentationMode)
				} label :{
					Image(systemName: "checkmark")
						.padding(8)
				}.buttonStyle(BorderedProminentButtonStyle())
			}
		}
		.frame(maxWidth: maxWidth)
		.padding(24)
	}
}

