//
//  File.swift
//  
//
//  Created by Alidin on 19/04/23.
//

import Foundation

class Setting : Codable, ObservableObject{
	@Published var isOnboardingDone : Bool
	@Published var islabelInitialized : Bool
	@Published var isItemNameVisible  : Bool
	
	enum CodingKeys : String, CodingKey{
		case isOnboardingDone
		case islabelInitialized
		case isItemNameVisible
	}
	
	init(){
		isOnboardingDone = false
		islabelInitialized = false
		isItemNameVisible = true
	}
	
	func save(){
		do{
			let settingData = try JSONEncoder().encode(self)
			UserDefaults.standard.set(settingData, forKey : "setting")
		}catch{
			print("Error encoding Setting object: \(error.localizedDescription)")
		}
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
	
		isOnboardingDone = try container.decode(Bool.self, forKey: .isOnboardingDone)
		isItemNameVisible = try container.decode(Bool.self, forKey: .isItemNameVisible)
		islabelInitialized = try container.decode(Bool.self, forKey: .islabelInitialized)
		isItemNameVisible = try container.decode(Bool.self, forKey: .isItemNameVisible)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(isOnboardingDone, forKey: .isOnboardingDone)
		try container.encode(islabelInitialized, forKey: .islabelInitialized)
		try container.encode(isItemNameVisible, forKey: .isItemNameVisible)
	}
}
