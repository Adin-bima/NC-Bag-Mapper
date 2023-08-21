//
//  SwiftUIView.swift
//  
//
//  Created by Alidin on 17/04/23.
//

import SwiftUI

struct LegendContainer: View {
	@EnvironmentObject var dataContainer : DataContainer
	
	@Binding var bag : Bag
	@Binding var selectedLabel : String
	@Binding var isOpened : Bool
	
	@State var isAddingNew = false
	@State var newLabelName = ""
	@State var newLabelColor = Color.white
	
	@GestureState var dragOffset = CGSize.zero
	
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
			}
			.frame(height: 80)
			.background(Color.white)
			.cornerRadius(8)
			.padding(.top, 8)
			.padding(.trailing, 8)
			.opacity(0.8)
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
									isAddingNew.toggle()
								}
								.buttonStyle(BorderedProminentButtonStyle())
								.popover(isPresented: $isAddingNew) {
									VStack{
										HStack(spacing : 4){
											
											ColorPicker("", selection: $newLabelColor, supportsOpacity: false)
												.padding()
											
											TextField("Label", text: $newLabelName)
												.frame(width: 120)
												.textFieldStyle(.roundedBorder)
											
											Button {
												let newLabel = ItemLabel(id: UUID().uuidString, labelName: newLabelName, labelColor: newLabelColor)
												newLabel.save()
												dataContainer.labels.append(newLabel)
												
												newLabelName = ""
												newLabelColor = Color.white
												
												isAddingNew = false
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
