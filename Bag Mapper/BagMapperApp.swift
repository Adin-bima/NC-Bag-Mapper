//
//  Bag_MapperApp.swift
//  Bag Mapper
//
//  Created by Alidin on 23/08/23.
//

import SwiftUI

@main
struct BagMapperApp: App {
	@StateObject var globalState = AppGlobalStateViewModel()
	
	var body: some Scene {
		WindowGroup {
			if(globalState.setting.isOnboardingDone){
				MainLayout()
					.environmentObject(globalState)
				
			}else{
				OnboardingView()
					.environmentObject(globalState)
				
			}
		}
	}
}
