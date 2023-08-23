//
//  File.swift
//  
//
//  Created by Alidin on 16/04/23.
//

import SwiftUI


struct MainLayout : View{
	@EnvironmentObject var globalState : AppGlobalStateViewModel
	@StateObject var mainLayoutViewModel = MainLayoutViewModel()
	
	var body: some View{
		NavigationSplitView() {
			BagListView()
				.environmentObject(mainLayoutViewModel)
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
			NoBagSelectedView()
				.navigationBarBackButtonHidden()
				.onAppear(){
					if(!globalState.setting.isOnboardingDone){
						globalState.setting.isOnboardingDone.toggle()
						AppSettingService.shared.save(setting : globalState.setting)
					}
				}
		}
		.onAppear{
			mainLayoutViewModel.loadAllBag()
			mainLayoutViewModel.loadAllLabels()
			
		}
		
		.navigationBarBackButtonHidden()
	}
}
