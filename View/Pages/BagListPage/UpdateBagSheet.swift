//
//  SwiftUIView.swift
//  
//
//  Created by Alidin on 17/04/23.
//

import SwiftUI

struct UpdateBagSheet: View {
	@Binding var bag : Bag
	@Binding var isPresented: Bool
	@State private var bagName: String = ""
	@State private var notes: String = ""
	
	@State var isShowingActionSheet : Bool = false
	
	init(bag: Binding<Bag>, isPresented: Binding<Bool>) {
		_bag = bag
		_isPresented = isPresented
		_bagName = State(initialValue: bag.bagName.wrappedValue)
		_notes = State(initialValue: bag.notes.wrappedValue)
	}
	
	var body: some View {
		NavigationView {
			VStack( alignment : .leading, spacing: 16) {
				VStack(alignment: .leading, spacing : 8) {
					
					Text("Bag Name")
					TextField("Bag Name", text: $bagName)
						.padding()
						.background(Color(.systemBackground))
						.cornerRadius(8)
						.overlay(
							RoundedRectangle(cornerRadius: 8)
								.stroke(Color("lightGray"), lineWidth: 1) // Add a stroke with the primary color
						)
				}
				
				VStack(alignment: .leading, spacing : 8) {
					Text("Notes (optional)")
					TextEditor(text: $notes)
						.padding()
						.background(Color(.systemBackground))
						.cornerRadius(8)
						.overlay(
							RoundedRectangle(cornerRadius: 8)
								.stroke(Color("lightGray"), lineWidth: 2) // Add a stroke with the primary color
						).frame(height: 100)
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
						isPresented = false
					}
					.foregroundColor(.teal),
				
				trailing:
					Button("Save"){
						bag.bagName = bagName
						bag.notes = notes
						bag.save()
						
						isPresented = false
						
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
