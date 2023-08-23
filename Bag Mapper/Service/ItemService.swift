//
//  File.swift
//  
//
//  Created by Alidin on 23/08/23.
//

import Foundation

import Foundation

class ItemService {
	static var shared = ItemService()
	
	private init(){}
	
	func saveItem(_ item: Item) -> ServiceResponse<Void> {
		do {
			let itemData = try JSONEncoder().encode(item)
			UserDefaults.standard.set(itemData, forKey: "item_\(item.id)")
			return ServiceResponse.success("Item has been successfully saved", nil)
		} catch {
			return ServiceResponse.error("Failed to save item : \(error.localizedDescription)")
		}
	}
	
	func loadItems(id: String) -> ServiceResponse<Item> {
		if let itemData = UserDefaults.standard.data(forKey: "item_\(id)"),
		   let item = try? JSONDecoder().decode(Item.self, from: itemData) {
			return ServiceResponse.success("Item successfully retrieved", item)
		}
		return ServiceResponse.error("Failed to load item")
	}
	
	func deleteItemByid(_ itemId: String)  -> ServiceResponse<Void> {
		UserDefaults.standard.removeObject(forKey: "item_\(itemId)")
		return ServiceResponse.success("Item successfully deleted", nil)
	}
	
	func loadAllItemsByBag(bagId: String) -> ServiceResponse<[Item]> {
		var items: [Item] = []
		let keys = UserDefaults.standard.dictionaryRepresentation().keys
		for key in keys {
			if key.hasPrefix("item_"),
			   let itemData = UserDefaults.standard.data(forKey: key),
			   let item = try? JSONDecoder().decode(Item.self, from: itemData),
			   item.bagId == bagId {
				items.append(item)
			}
		}
		items = items.sorted { i1, i2 in
			i1.itemName.lowercased() < i2.itemName.lowercased()
		}
		
		return ServiceResponse.success("Bag Items successfully retrieved", items)
	}
	
	func loadAllByBagAndLabel(bagId: String, labelId : String) -> ServiceResponse<[Item]> {
		var items: [Item] = []
		let keys = UserDefaults.standard.dictionaryRepresentation().keys
		for key in keys {
			if key.hasPrefix("item_"),
			   let itemData = UserDefaults.standard.data(forKey: key),
			   let item = try? JSONDecoder().decode(Item.self, from: itemData),
			   item.bagId == bagId && item.labelId == labelId {
				items.append(item)
			}
		}
		
		items = items.sorted { i1, i2 in
			i1.itemName.lowercased() < i2.itemName.lowercased()
			
		}
		
		return ServiceResponse.success("Bag Items successfully retrieved", items)
	}
	
	func loadAllItemsByLabel(labelId: String) -> ServiceResponse<[Item]> {
		var items: [Item] = []
		let keys = UserDefaults.standard.dictionaryRepresentation().keys
		for key in keys {
			if key.hasPrefix("item_"),
			   let itemData = UserDefaults.standard.data(forKey: key),
			   let item = try? JSONDecoder().decode(Item.self, from: itemData),
			   item.labelId == labelId {
				items.append(item)
			}
		}
		items = items.sorted { i1, i2 in
			i1.itemName.lowercased() < i2.itemName.lowercased()
		}
		
		return ServiceResponse.success("Bag Items successfully retrieved", items)
	}

}

