//
//  AppGlobalStateViewModel.swift
//  
//
//  Created by Alidin on 23/08/23.
//

import SwiftUI

class AppGlobalStateViewModel : ObservableObject{
	@Published var setting : AppSetting
	
	init(){
		
		// comment this if you want to reset app to default
//		deleteAllItemsFromUserDefaults()
//		_ = deleteAllImagesFromLocalStorage()

		setting = AppSettingService.shared.loadSetting()
		
//		self.setting.isOnboardingDone = false
		
		if (!setting.islabelInitialized){
			let newLabels = [ItemLabel(id: UUID().uuidString, labelName: "Cards", labelColor: Color.red.toHex()),
							 ItemLabel(id: UUID().uuidString, labelName: "Keys", labelColor: Color.orange.toHex()),
							 ItemLabel(id: UUID().uuidString, labelName: "Stationery", labelColor: Color.yellow.toHex()),
							 ItemLabel(id: UUID().uuidString, labelName: "Electronics", labelColor: Color.green.toHex()),
							 ItemLabel(id: UUID().uuidString, labelName: "Makeup", labelColor: Color.blue.toHex())]
			
			for newLabel in newLabels {
				_ = ItemLabelService.shared.saveItemLabel(newLabel)
			}
			setting.islabelInitialized = true
			
			AppSettingService.shared.save(setting: setting)
		}
	}
}
