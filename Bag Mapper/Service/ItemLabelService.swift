//
//  File.swift
//  
//
//  Created by Alidin on 23/08/23.
//

import Foundation

struct ItemLabelService {
	static var shared = ItemLabelService()
	
	private init(){}
	
	func saveItemLabel(_ label: ItemLabel) -> ServiceResponse<Void> {
		let labelData = try? JSONEncoder().encode(label)
		UserDefaults.standard.set(labelData, forKey: "label_\(label.id)")
		return ServiceResponse.success("Item Label has been successfully saved", nil)
	}
	
	func loadItemLabelById(id: String) -> ServiceResponse<ItemLabel> {
		if let labelData = UserDefaults.standard.data(forKey: "label_\(id)"),
		   let label = try? JSONDecoder().decode(ItemLabel.self, from: labelData) {
			return ServiceResponse.success("Item Label successfully retrieved", label)
		}
		return ServiceResponse.error("Failed to retrieve Item Label")
	}
	
	
	func deleteItemLabelById(_ labelId : String) -> ServiceResponse<Void> {
		UserDefaults.standard.removeObject(forKey: "label_\(labelId)")
		
		_ = UserDefaults.standard.dictionaryRepresentation().keys
		
		if let items = ItemService.shared.loadAllItemsByLabel(labelId: labelId).data {
			for item in items {
				_ = ItemService.shared.deleteItemByid(item.id)
			}
		}
		
		return ServiceResponse.success("Item Label successfully deleted", nil)
	}
	
	
	func LoadItemLabels() -> ServiceResponse<[ItemLabel]> {
		var labels: [ItemLabel] = []
		let keys = UserDefaults.standard.dictionaryRepresentation().keys
		for key in keys {
			if key.hasPrefix("label_"),
			   let labelData = UserDefaults.standard.data(forKey: key),
			   let label = try? JSONDecoder().decode(ItemLabel.self, from: labelData) {
				labels.append(label)
			}
		}
		
		labels = labels.sorted { b1, b2 in
			b1.labelName.lowercased() < b2.labelName.lowercased()
		}
		
		return ServiceResponse.success("Item Labels successfully retrieved", labels)
	}
}
