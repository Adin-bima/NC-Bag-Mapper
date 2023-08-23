//
//  BagService.swift
//  
//
//  Created by Alidin on 23/08/23.
//

import SwiftUI

class BagService {
	static var shared = BagService()
	
	private init(){}
	
	func saveBag(_ bag: Bag) -> ServiceResponse<Bag>{
		do {
			let bagData = try JSONEncoder().encode(bag)
			UserDefaults.standard.set(bagData, forKey: "bag_\(bag.id)")
			return ServiceResponse.success("Bag has been successfully saved", nil)
		} catch {
			return ServiceResponse.error("Failed to save bag : \(error.localizedDescription)")
		}
	}
	
	func loadBagById(id: String) -> ServiceResponse<Bag> {
		if let bagData = UserDefaults.standard.data(forKey: "bag_\(id)"),
		   let bag = try? JSONDecoder().decode(Bag.self, from: bagData) {
			return ServiceResponse.success("Bag successfully loaded", bag)
		}
		return ServiceResponse.error("Failed to retrive bag : bag not found")
	}
	
	func deleteBagById(_ id : String) -> ServiceResponse<Void> {
		if let data = self.loadItemsByBagId(bagId : id).data{
			for item in data {
				_ = ItemService.shared.deleteItemByid(item.id)
			}
			
			let _ = deleteImageFromLocalStorage(imageId: id)
			UserDefaults.standard.removeObject(forKey: "bag_\(id)")
			return ServiceResponse.success("", nil)
		}
		
		return ServiceResponse.error("Failed to delete data")
	}
	
	func loadBags() -> ServiceResponse<[Bag]> {
		var bags: [Bag] = []
		let keys = UserDefaults.standard.dictionaryRepresentation().keys
		for key in keys {
			if key.hasPrefix("bag_"),
			   let bagData = UserDefaults.standard.data(forKey: key),
			   let bag = try? JSONDecoder().decode(Bag.self, from: bagData) {
				bags.append(bag)
			}
		}
		bags = bags.sorted { b1, b2 in b1.bagName.lowercased() < b2.bagName.lowercased() }
		return ServiceResponse.success("Bags successfully retrieved", bags)
	}
	
	func loadItemsByBagId( bagId: String) -> ServiceResponse<[Item]> {
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
		
		return ServiceResponse.success("Bag items successfully retrieved", items)
	}
	
	func getImage(bagId : String) -> UIImage? {
		// Get the file URL for the app's documents directory
		guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
			return nil
		}

		// Append the image name to the documents directory URL
		let fileURL = documentsDirectory.appendingPathComponent(bagId+".png")

		// Check if the file exists at the file URL
		if FileManager.default.fileExists(atPath: fileURL.path) {
			// Load the image data from the file URL
			if let image = UIImage(contentsOfFile: fileURL.path) {
				return image
			}
		}

		// Return nil if image not found or failed to load
		return nil
	}
	
}
