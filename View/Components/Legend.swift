//
//  SwiftUIView.swift
//  
//
//  Created by Alidin on 17/04/23.
//

import SwiftUI

struct Legend: View {
	@Binding var bag : Bag
	
	@Binding var selectedLabel : String
	
	@EnvironmentObject var dataContainer : DataContainer
	
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
												let newLabel = Label(id: UUID().uuidString, labelName: newLabelName, labelColor: newLabelColor)
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
	}
}
//
//struct Legend_Previews: PreviewProvider {
//	static var previews: some View {
//		Legend()
//	}
//}
