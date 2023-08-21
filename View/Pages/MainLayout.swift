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
	
	var body: some View{
		NavigationSplitView() {
			BagListView(selectedBagId: $selectedBagId)
				.navigationTitle("My Bags")
				
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
