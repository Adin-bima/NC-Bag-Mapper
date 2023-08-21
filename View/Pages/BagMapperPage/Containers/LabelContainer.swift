//
//  SwiftUIView.swift
//  
//
//  Created by Alidin on 21/08/23.
//

import SwiftUI

struct LabelContainer: View {
	@ObservedObject var legendContainerViewModel : LegendContainerViewModel
	
	@Binding var bag : Bag
	@Binding var selectedLabel : String
	@Binding var isOpened : Bool
	
	var onLabelDeletion : (_ : String, _ : Bag)->Void
	
	@EnvironmentObject var dataContainer : DataContainer
	
	
	var body: some View {
		VStack{
			VStack{
				HStack{
					Text("Labels").foregroundColor(Color.black)
					
					Spacer()
					
					Image(systemName: "plus")
						.foregroundColor(Color.blue)
						.onTapGesture {
							legendContainerViewModel.isAddingNew.toggle()
						}
					
						.buttonStyle(BorderedProminentButtonStyle())
						.popover(isPresented: $legendContainerViewModel.isAddingNew) {
							NewLabelView(legendContainerViewModel: legendContainerViewModel)
						}
					
				}
				.padding(.bottom, 2)
				Divider()
				
				ScrollView{
					VStack (spacing: 0) {
						Button {
							selectedLabel = ""
						} label: {
							HStack(spacing : 8) {
								
								Image(systemName: "circle.fill").foregroundColor(Color.gray)
								
								Text("All")
									.foregroundColor(Color.black)
								
								Spacer()
								
								
							}
							.multilineTextAlignment(.leading)
						}
						.padding(4)
						.background(
							selectedLabel == "" ? Color.gray.opacity(0.5) : Color.clear
						)
						.clipShape(
							RoundedRectangle(cornerRadius: 4)
						)
						
						.frame(maxWidth: .infinity	)
						
						ForEach( dataContainer.labels, id:\.id ){
							label in
							
							Button {
								selectedLabel = label.id
							} label: {
								HStack(spacing : 8) {
									
									Image(systemName: "circle.fill").foregroundColor(label.labelColor)
									
									Text("\(label.labelName)")
										.foregroundColor(Color.black)
									
									Spacer()
									
									Image(systemName: "trash").onTapGesture {
										label.delete()
										onLabelDeletion(label.id, bag)
										dataContainer.labels = dataContainer.labels.filter({ originalLabel in
											return originalLabel.id != label.id
										})
									}
									.foregroundColor(Color.red)
								}
								.multilineTextAlignment(.leading)
							}
							.padding(4)
							.background(
								selectedLabel == label.id ? label.labelColor.opacity(0.5) : Color.clear
							)
							.clipShape(
								RoundedRectangle(cornerRadius: 4)
							)
							.frame(maxWidth: .infinity	)
						}
					}
					
					
				}
			}
			
			
		}
		
		.padding()
		.frame(width: isOpened ? 200 : 0, height: 300)
		.background(Color.white)
		.cornerRadius(8)
		.padding(.trailing, isOpened ? 8 : 0) // Add padding based on isOpened
		.transition(AnyTransition.move(edge: .trailing))
		.opacity(0.8)
		
	}
}


