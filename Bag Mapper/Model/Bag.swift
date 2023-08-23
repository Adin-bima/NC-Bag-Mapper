//
//  Bag.swift
//  
//
//  Created by Alidin on 16/04/23.
//

import Foundation
import SwiftUI

struct Bag: Equatable, Codable, Identifiable {
	var id: String
	var bagName: String
	var notes: String
	var isFavorite: Bool = false
	
	static func == (lhs: Bag, rhs: Bag) -> Bool {
		return lhs.id == rhs.id
	}
}



// Other parts of your code that are not directly related to Bag or BagService
// ...




//
//struct Bag : Codable, Identifiable, Equatable{
//	var id : String
//	var bagName : String
//	var notes : String
//	var isFavorite : Bool = false
//
//	static func == (lhs: Bag, rhs: Bag) -> Bool {
//		// Your implementation for comparing two Bag instances for equality
//		// Return true if they are equal, and false otherwise
//		return lhs.id == rhs.id
//	}
//
//	enum CodingKeys: String, CodingKey {
//		case id
//		case bagName
//		case notes
//		case isFavorite
//	}
//
//	init(id: String, bagName: String, notes: String) {
//		self.id = UUID().uuidString
//		self.bagName = bagName
//		self.notes = notes
//	}
//
//	// MARK: - model relation
//	func items()->[Item]{
//		let items = Item.loadAll().filter { item in
//			return item.bagId == self.id
//		}
//
//		return items
//	}
//
//
//
//	// MARK: - CRUD Operations
//
//	// Function to save a Bag instance to UserDefaults
//	func save() {
//		do {
//			let bagData = try JSONEncoder().encode(self)
//			UserDefaults.standard.set(bagData, forKey: "bag_\(id)")
//		} catch {
//			print("Error encoding Bag object: \(error.localizedDescription)")
//		}
//	}
//
//	// Function to load a Bag instance from UserDefaults
//	static func load(id: String) -> Bag? {
//		if let bagData = UserDefaults.standard.data(forKey: "bag_\(id)"),
//		   let bag = try? JSONDecoder().decode(Bag.self, from: bagData) {
//			return bag
//		}
//		return nil
//	}
//
//	// Function to delete a Bag instance from UserDefaults
//	func delete() {
//		for item in items(){
//			item.delete()
//		}
//		let _ = deleteImageFromLocalStorage(imageId: id)
//		UserDefaults.standard.removeObject(forKey: "bag_\(id)")
//	}
//
//	// Function to load all Bag instances from UserDefaults
//	static func loadAll() -> [Bag] {
//		var bags: [Bag] = []
//		let keys = UserDefaults.standard.dictionaryRepresentation().keys
//		for key in keys {
//			if key.hasPrefix("bag_"),
//			   let bagData = UserDefaults.standard.data(forKey: key),
//			   let bag = try? JSONDecoder().decode(Bag.self, from: bagData) {
//				bags.append(bag)
//			}
//		}
//		return bags.sorted { b1, b2 in
//			b1.bagName.lowercased() < b2.bagName.lowercased()
//		}
//	}
//

//
//	init(from decoder: Decoder) throws {
//		let container = try decoder.container(keyedBy: CodingKeys.self)
//		id = try container.decode(String.self, forKey: .id)
//		bagName = try container.decode(String.self, forKey: .bagName)
//		notes = try container.decode(String.self, forKey: .notes)
//		isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
//	}
//
//	func encode(to encoder: Encoder) throws {
//		var container = encoder.container(keyedBy: CodingKeys.self)
//		try container.encode(id, forKey: .id)
//		try container.encode(bagName, forKey: .bagName)
//		try container.encode(notes, forKey: .notes)
//		try container.encode(isFavorite, forKey: .isFavorite)
//	}
//}
