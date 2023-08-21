//
//  SwiftUIView.swift
//  
//
//  Created by Alidin on 17/04/23.
//

import SwiftUI

struct UpdateBagSheet: View {
	@Binding var bag : Bag
	@State private var bagName: String = ""
	@State private var notes: String = ""
	@State var isShowingActionSheet : Bool = false
	
	@Environment(\.presentationMode) var presentationModel
	
	init(bag: Binding<Bag>) {
		_bag = bag
		_bagName = State(initialValue: bag.bagName.wrappedValue)
		_notes = State(initialValue: bag.notes.wrappedValue)
	}
	
	var body: some View {
		NavigationView {
			VStack( alignment : .leading, spacing: 16) {
				VStack(alignment: .leading, spacing : 8) {
					
					Text("Bag Name")
					TextField("Bag Name", text: $bagName)
						.primaryStyled()
				}
				
				VStack(alignment: .leading, spacing : 8) {
					Text("Notes (optional)")
					TextEditor(text: $notes)
						.primaryStyled()
						.frame(height: 100)
				}
				Spacer()
			}
			.padding()
			.navigationBarTitle("Add Bag", displayMode: .inline)
			.navigationBarItems(
				leading:
					Button("Cancel") {
						bagName = bag.bagName
						notes = bag.notes
						presentationModel.wrappedValue.dismiss()
					}
					.foregroundColor(.teal),
				
				trailing:
					Button("Save"){
						bag.bagName = bagName
						bag.notes = notes
						bag.save()
						
						presentationModel.wrappedValue.dismiss()
						
					}
					.disabled(
						bagName.isEmpty
					)
					.foregroundColor(bagName.isEmpty ? .gray : .teal)
				
			)
		}
		
	}
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIView()
//    }
//}
