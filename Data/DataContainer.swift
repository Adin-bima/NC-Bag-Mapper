//
//  File.swift
//  
//
//  Created by Alidin on 16/04/23.
//

import Foundation
import SwiftUI

class DataContainer: ObservableObject{
	@Published var bags : [Bag] = []
	@Published var labels : [ItemLabel] = []
	@Published var setting : Setting
	@Published var columnVisibility = NavigationSplitViewVisibility.doubleColumn
	
	
	init(){
		if let settingData = UserDefaults.standard.data(forKey: "setting")
		{
			let setting = try? JSONDecoder().decode(Setting.self, from: settingData)
			self.setting = setting ?? Setting()
		}else{
			let setting = Setting()
			setting.save()
			self.setting = setting
		}
		
		self.setting.isOnboardingDone = false
		
		if (!setting.islabelInitialized){
			ItemLabel(id: UUID().uuidString, labelName: "Cards", labelColor: Color.red).save()
			ItemLabel(id: UUID().uuidString, labelName: "Keys", labelColor: Color.orange).save()
			ItemLabel(id: UUID().uuidString, labelName: "Stationery", labelColor: Color.yellow).save()
			ItemLabel(id: UUID().uuidString, labelName: "Electronics", labelColor: Color.green).save()
			ItemLabel(id: UUID().uuidString, labelName: "Makeup", labelColor: Color.blue).save()
			setting.islabelInitialized = true
			setting.save()
		}
		
		labels = ItemLabel.loadAll()
	}
}
