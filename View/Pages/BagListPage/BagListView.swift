//
//  SwiftUIView.swift
//  
//
//  Created by Alidin on 16/04/23.
//

import SwiftUI


struct BagListView: View {
	@EnvironmentObject var dataContainer : DataContainer
	@StateObject var bagListViewModel = BagListViewModel()
	@Binding var selectedBagId : String
	
	var body: some View {
		
		VStack(alignment : .leading, spacing: 8){
			Text("Favorite Bags")
				.padding(.horizontal)
				.foregroundColor(.gray)
			
			
			if dataContainer.bags.filter({ bag in return bag.isFavorite }).isEmpty {
				Text("No favorite bags")
					.padding()
					.foregroundColor(.gray)
					.frame(maxWidth: .infinity)
					.background(Color(UIColor.systemGroupedBackground))
				
			} else {
				List {
					ForEach ($dataContainer.bags.filter { $0.isFavorite.wrappedValue  }, id:\.id){
						$bag in
						NavigationLink(destination: BagMapView(bag : $bag) ){
							BagItemView(bag: $bag, selectedBagId: $selectedBagId)
						}
					}
				}
			}
			
			Text("Other Bags")
				.padding(.horizontal)
				.foregroundColor(.gray)
			
			
			if dataContainer.bags.filter({ bag in return !bag.isFavorite }).isEmpty {
				Text("No bags available")
					.padding()
					.foregroundColor(.gray)
					.frame(maxWidth: .infinity)
					.background(Color(UIColor.systemGroupedBackground))
				
			} else {
				List {
					ForEach ($dataContainer.bags.filter { !$0.isFavorite.wrappedValue  }, id:\.id){
						$bag in
						NavigationLink(destination: BagMapView(bag : $bag) ){
							BagItemView(bag: $bag, selectedBagId: $selectedBagId)
						}
					}
					
				}
				.frame(maxHeight: .infinity)
			}
			
			Spacer()
			
		}
		
		.sheet(isPresented: $bagListViewModel.isShowingAddNewBagModal, content: {
			AddBagSheet()
		})
		.navigationBarItems(
			trailing: // Add the "+" button to the trailing side of the navigation bar
			Button(action: {
				bagListViewModel.isShowingAddNewBagModal = true
			}, label: {
				Image(systemName: "plus")
			})
		)
		
		
	}
	
	
	
}

