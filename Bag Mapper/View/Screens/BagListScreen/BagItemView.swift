//
//  BagItemView.swift
//  
//
//  Created by Alidin on 16/04/23.
//

import SwiftUI

struct BagItemView: View {
	@EnvironmentObject var mainLayoutViewModel : MainLayoutViewModel
	@StateObject var bagItemViewModel = BagItemViewModel()
	
	@Binding var bag : Bag
	@Binding var selectedBagId : String
	
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
					bagItemViewModel.toggleFavorite(bag : $bag)
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
					bagItemViewModel.isUpdating.toggle()
				}) {
					HStack(spacing : 8){
						Image(systemName: "square.and.pencil")
						Text("Edit")
					}
				}
				
				Button(action: {
					bagItemViewModel.isDeleting.toggle()
				}) {
					HStack(spacing : 9){
						Image(systemName: "trash")
						Text("Delete")
							.foregroundColor(.red)
					}
				}
			}
			.swipeActions(edge : .leading, allowsFullSwipe: false) {
				leadingSwipeAction()
			}
			.swipeActions(edge : .trailing, allowsFullSwipe: false){
				trailingSwipeAction()
			}
			.alert(isPresented: $bagItemViewModel.isDeleting) {
				Alert(title: Text("Delete Bag \(bag.bagName)"), message: Text("This action cannot be undone."), primaryButton: .destructive(Text("Delete")) {
					bagItemViewModel.deleteBag(bag: $bag)
					mainLayoutViewModel.loadAllBag()
					
				}, secondaryButton: .cancel())
			}
			.sheet(isPresented: $bagItemViewModel.isUpdating) {
				UpdateBagSheet(bag : $bag)
			}
	}
	
	private func leadingSwipeAction() -> some View {
		return Group{
			Button(action: {
				bagItemViewModel.toggleFavorite(bag : $bag)
			}) {
				Image(systemName: bag.isFavorite ? "star.slash" : "star")
			}
			.tint(bag.isFavorite ? .secondary : .teal)
		
		}
	}
	
	private func trailingSwipeAction() -> some View {
		return Group{
			Button(action: {
				bagItemViewModel.isDeleting.toggle()
			}) {
				Image(systemName: "trash").foregroundColor(.red)
			}
			.tint(.red)
			
		}
	}
	
	
}
