//
//  BagListView.swift
//  
//
//  Created by Alidin on 16/04/23.
//

import SwiftUI


struct BagListView: View {
	@EnvironmentObject var mainLayoutViewModel : MainLayoutViewModel
	
	var body: some View {
	
		VStack(alignment : .leading, spacing: 8){
			Text("Favorite Bags")
				.padding(.horizontal)
				.foregroundColor(.gray)
				
			
			if mainLayoutViewModel.bags.filter({ bag in return bag.isFavorite }).isEmpty {
				Text("No favorite bags")
					.padding()
					.foregroundColor(.gray)
					.frame(maxWidth: .infinity)
					.background(Color(UIColor.systemGroupedBackground))
					
			} else {
				List {
					ForEach ($mainLayoutViewModel.bags.filter { $0.isFavorite.wrappedValue  }, id:\.id){
						$bag in
						NavigationLink(destination: BagMapView(bag : $bag) ){
							BagItemView(bag: $bag, selectedBagId: $mainLayoutViewModel.selectedBagId)
						}
					}
				}
			}
			
			Text("Other Bags")
				.padding(.horizontal)
				.foregroundColor(.gray)
				
			
			if mainLayoutViewModel.bags.filter({ bag in return !bag.isFavorite }).isEmpty {
				Text("No bags available")
					.padding()
					.foregroundColor(.gray)
					.frame(maxWidth: .infinity)
					.background(Color(UIColor.systemGroupedBackground))
					
			} else {
				List {
					ForEach ($mainLayoutViewModel.bags.filter { !$0.isFavorite.wrappedValue  }, id:\.id){
						$bag in
						NavigationLink(destination: BagMapView(bag : $bag).environmentObject(mainLayoutViewModel) ){
							BagItemView(bag: $bag, selectedBagId: $mainLayoutViewModel.selectedBagId)
						}
					}
					
				}
				.frame(maxHeight: .infinity)
			}
			
			Spacer()
		
		}
			
		.sheet(isPresented: $mainLayoutViewModel.isShowingAddBagModal, content: {
			AddBagSheet()
		})
		
		
	}
	
	
	
}

