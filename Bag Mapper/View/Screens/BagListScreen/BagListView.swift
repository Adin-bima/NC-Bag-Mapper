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
			
			
			List {
				
				Section(header : Text("Favorites")){
					
					ForEach ($mainLayoutViewModel.bags, id:\.id){
						$bag in
						if(bag.isFavorite){
							
							NavigationLink(destination: BagMapView(bag : $bag).environmentObject(mainLayoutViewModel) ){
								BagItemView(bag: $bag, selectedBagId: $mainLayoutViewModel.selectedBagId)
									
							}
						}
					}
				}
				
				
				Section(header : Text("Other")){
					
					ForEach ($mainLayoutViewModel.bags, id:\.id){
						$bag in
						if(!bag.isFavorite){
							
							NavigationLink(destination: BagMapView(bag : $bag).environmentObject(mainLayoutViewModel) ){
								BagItemView(bag: $bag, selectedBagId: $mainLayoutViewModel.selectedBagId)
									

							}
						}
					}
				}
				
			}.listRowSeparator(.hidden)
			
			
			
			
			Spacer()
			
		}
		
		.sheet(isPresented: $mainLayoutViewModel.isShowingAddBagModal, content: {
			AddBagSheet()
		})
		
		
	}
	
	
	
}

