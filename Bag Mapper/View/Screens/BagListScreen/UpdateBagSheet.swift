//
//  UpdateBagSheet.swift
//  
//
//  Created by Alidin on 17/04/23.
//

import SwiftUI

struct UpdateBagSheet: View {
	@Binding var bag : Bag
	
	@StateObject var updateBagViewModel = UpdateBagViewModel()
	@Environment(\.presentationMode) var presentationModel
	
	init(bag: Binding<Bag>) {
		_bag = bag
	}
	
	var body: some View {
		NavigationView {
			VStack( alignment : .leading, spacing: 16) {
				VStack(alignment: .leading, spacing : 8) {
					
					Text("Bag Name")
					TextField("Bag Name", text: $updateBagViewModel.bagName)
						.primaryStyled()
				}
				
				VStack(alignment: .leading, spacing : 8) {
					Text("Notes (optional)")
					TextEditor(text: $updateBagViewModel.notes)
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
						updateBagViewModel.cancelUpdate(bag: bag)
						presentationModel.wrappedValue.dismiss()
					}
					.foregroundColor(.teal),
				
				trailing:
					Button("Save"){
						updateBagViewModel.saveBag(bag: $bag)
						presentationModel.wrappedValue.dismiss()
					}
					.disabled(
						updateBagViewModel.bagName.isEmpty
					)
					.foregroundColor(updateBagViewModel.bagName.isEmpty ? .gray : .teal)
				
			)
			.onAppear(){
				updateBagViewModel.bagName = bag.bagName
				updateBagViewModel.notes = bag.notes
			}
		}
		
	}
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIView()
//    }
//}
