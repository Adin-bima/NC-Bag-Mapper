//
//  SwiftUIView.swift
//  
//
//  Created by Alidin on 17/04/23.
//

import SwiftUI

struct LegendContainer: View {
	@EnvironmentObject var dataContainer : DataContainer
	@Environment(\.presentationMode) var presentationMode
	@StateObject var legendViewModel = LegendContainerViewModel()
	
	@GestureState var dragOffset = CGSize.zero
	
	@Binding var bag : Bag
	@Binding var selectedLabel : String
	@Binding var isOpened : Bool
	
	var onLabelDeletion : (_ : String, _ : Bag)->Void
	var body: some View {
		HStack(alignment : .center, spacing: 0){
			Spacer()
			
			Button {
				withAnimation(.easeOut){
					self.isOpened.toggle()
				}
			} label: {
				Image(systemName: isOpened ? "chevron.right" : "chevron.left")
					.frame(width: 32, height: 40)
					.foregroundColor(Color.black)
					.frame(height: 80)
					.background(Color.white.opacity(0.8))
					.cornerRadius(8)
					.padding(.top, 8)
					.padding(.trailing, 8)
			}
			
			.offset( CGSize(width: dragOffset.width, height: 0) )
			
			if(isOpened ){
				VStack{
					VStack{
						HStack{
							Text("Labels").foregroundColor(Color.black)
							
							Spacer()
							
							
							Image(systemName: "plus")
								.foregroundColor(Color.blue)
								.onTapGesture {
									legendViewModel.isAddingNew.toggle()
								}
								.buttonStyle(BorderedProminentButtonStyle())
								.popover(isPresented: $legendViewModel.isAddingNew) {
									VStack{
										HStack(spacing : 4){
											
											ColorPicker("", selection: $legendViewModel.newLabelColor, supportsOpacity: false)
												.padding()
											
											TextField("Label", text: $legendViewModel.newLabelName)
												.frame(width: 120)
												.textFieldStyle(.roundedBorder)
											
											Button {
												legendViewModel.saveNewLabel(labels: $dataContainer.labels)
												
											} label: {
												Image(
													systemName: "checkmark"
												)
												.frame(width: 8)
											}.buttonStyle(.borderedProminent)
										}
										
									}.padding(8)
								}
							
						}
						.padding(.bottom, 2)
						Divider()
						
						ScrollView{
							LabelContainer(bag: $bag, selectedLabel: $selectedLabel, onLabelDeletion: onLabelDeletion)
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
	}
}
