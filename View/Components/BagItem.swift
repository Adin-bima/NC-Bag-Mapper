//
//  SwiftUIView.swift
//  
//
//  Created by Alidin on 16/04/23.
//

import SwiftUI

struct BagItem: View {
	@Binding var bag : Bag
	@Binding var selectedBagId : String
	
	@State var isDeleting : Bool = false
	@State var isUpdating : Bool = false
	
	@EnvironmentObject var dataContainer : DataContainer
	
	var body: some View {
		
		HStack {
			VStack(alignment: .leading, spacing : 8) {
				Text(bag.bagName).font(.headline)
				Text(bag.notes).foregroundColor(Color.gray)
			}
			Spacer()
		}.padding(8)
			.contextMenu{
				
				Button(action: {
					bag.isFavorite.toggle()
					bag.save()
					dataContainer.bags = Bag.loadAll()
					
				}) {
					HStack(spacing:8){
						if(bag.isFavorite){
							Image(systemName: "star")
							Text("Remove from favorite")
						}else{
							Image(systemName: "star.fill")
							Text("Add to favorite")
						}
					}
				}
				
				Divider()
				
				Button(action: {
					isUpdating.toggle()
					
				}) {
					HStack(spacing : 8){
						Image(systemName: "square.and.pencil")
						Text("Update")
					}
				}
				
				Button(action: {
					isDeleting.toggle()
				}) {
					HStack(spacing : 9){
						Image(systemName: "trash")
						Text("Delete")
							.foregroundColor(.red)
					}
				}
			}
			.swipeActions(edge : .leading, allowsFullSwipe: false) {
				swipeActions(for: .leading)
			}
			.swipeActions(edge : .trailing, allowsFullSwipe: false){
				swipeActions(for: .trailing)
			}
			.alert(isPresented: $isDeleting) {
				Alert(title: Text("Delete Bag \(bag.bagName)"), message: Text("This action cannot be undone."), primaryButton: .destructive(Text("Delete")) {
					bag.delete()
					dataContainer.bags = dataContainer.bags.filter({ remainingBag in
						return remainingBag.id != bag.id
					})
				}, secondaryButton: .cancel())
			}
			.sheet(isPresented: $isUpdating) {
				UpdateBagView(bag : $bag, isPresented: $isUpdating)
			}
	}
	
	private func swipeActions(for edge: Edge) -> some View {
		return Group{
			Button(action: {
				bag.isFavorite.toggle()
				bag.save()
				
				dataContainer.bags = Bag.loadAll()
			}) {
				Image(systemName: bag.isFavorite ? "star.slash" : "star")
			}
			.tint(.secondary)
		
		}
	}
	
	
}
