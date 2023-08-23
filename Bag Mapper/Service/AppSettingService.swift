//
//  File.swift
//  
//
//  Created by Alidin on 23/08/23.
//

import Foundation


class AppSettingService {
	static let shared = AppSettingService()
	
	private init() {}
	
	func save(setting: AppSetting) {
		do {
			let settingData = try JSONEncoder().encode(setting)
			UserDefaults.standard.set(settingData, forKey: "setting")
		} catch {
			print("Error encoding Setting object: \(error.localizedDescription)")
		}
	}
	
	func loadSetting() -> AppSetting {
		if let settingData = UserDefaults.standard.data(forKey: "setting") {
			do {
				let setting = try JSONDecoder().decode(AppSetting.self, from: settingData)
				return setting
			} catch {
				print("Error decoding Setting object: \(error.localizedDescription)")
			}
		}
		return AppSetting(isOnboardingDone: false, islabelInitialized: false, isItemNameVisible: false)
	}
}
