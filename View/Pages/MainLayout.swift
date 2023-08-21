//
//  File.swift
//  
//
//  Created by Alidin on 16/04/23.
//

import SwiftUI


struct MainLayout : View{
	@EnvironmentObject var dataContainer : DataContainer
	
	@State var selectedBagId : String = ""
	@State var isShowingAddBagModal = false
	
	var body: some View{
		NavigationSplitView() {
			BagListView(selectedBagId: $selectedBagId, isShowingAddBagModal : $isShowingAddBagModal)
				.navigationTitle("My Bags")
				.navigationBarItems(
					trailing: // Add the "+" button to the trailing side of the navigation bar
					Button(action: {
						isShowingAddBagModal = true
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
