//
//  File.swift
//  
//
//  Created by Alidin on 16/04/23.
//

import SwiftUI


struct MainLayout : View{
	@EnvironmentObject var dataContainer : DataContainer
	@StateObject var mainLayoutViewModel = MainLayoutViewModel()
	
	var body: some View{
		NavigationSplitView() {
			BagListView(selectedBagId: $mainLayoutViewModel.selectedBagId, isShowingAddBagModal : $mainLayoutViewModel.isShowingAddBagModal)
				.navigationTitle("My Bags")
				.navigationBarItems(
					trailing: // Add the "+" button to the trailing side of the navigation bar
					Button(action: {
						mainLayoutViewModel.isShowingAddBagModal = true
					}, label: {
						Image(systemName: "plus")
					})
				)
				
		} detail: {
			NoBagSelectedView().navigationBarBackButtonHidden()
				.onAppear(){
					if(!dataContainer.setting.isOnboardingDone){
						dataContainer.setting.isOnboardingDone.toggle()
						dataContainer.setting.save()
					}
				}
		}
		.navigationBarBackButtonHidden()
	}
}
