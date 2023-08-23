//
//  ItemLabel.swift
//  
//
//  Created by Alidin on 16/04/23.
//

import Foundation
import SwiftUI

struct ItemLabel: Equatable, Codable, Identifiable {
	var id: String
	var labelName: String
	var labelColor: String
	
	static func == (lhs: ItemLabel, rhs: ItemLabel) -> Bool {
		return lhs.id == rhs.id
	}
}




//class ItemLabel : ObservableObject, Equatable{
//	static func == (lhs: ItemLabel, rhs: ItemLabel) -> Bool {
//		return lhs.id == rhs.id
//	}
//
//	@Published var id : String
//	@Published var labelName : String
//	@Published var labelColor : Color
//
//	enum CodingKeys: String, CodingKey {
//		case id
//		case labelName
//		case labelColor
//	}
//
//	init(id: String, labelName: String, labelColor: Color) {
//		self.id = id
//		self.labelName = labelName
//		self.labelColor = labelColor
//	}
//
//	// MARK: model relation
//	func items()->[Item]{
//		let items = Item.loadAll().filter({ item in
//			return item.labelId == self.id
//		})
//
//		return items
//	}
//
//	// MARK: - CRUD Operations
//
//	// Function to save a Label instance to UserDefaults
//	func save() {
//		let labelData = try? JSONEncoder().encode(self)
//		UserDefaults.standard.set(labelData, forKey: "label_\(id)")
//	}
//
//	// Function to load a Label instance from UserDefaults
//	static func load(id: String) -> ItemLabel? {
//		if let labelData = UserDefaults.standard.data(forKey: "label_\(id)"),
//			let label = try? JSONDecoder().decode(ItemLabel.self, from: labelData) {
//			return label
//		}
//		return nil
//	}
//
//	// Function to update a Label instance in UserDefaults
//	func update() {
//		save()
//	}
//
//	// Function to delete a Label instance from UserDefaults
//	func delete() {
//		items().forEach { item in
//			item.labelId = ""
//			item.save()
//		}
//		UserDefaults.standard.removeObject(forKey: "label_\(id)")
//	}
//
//	// Function to load all Label instances from UserDefaults
//	static func loadAll() -> [ItemLabel] {
//		var labels: [ItemLabel] = []
//		let keys = UserDefaults.standard.dictionaryRepresentation().keys
//		for key in keys {
//			if key.hasPrefix("label_"),
//				let labelData = UserDefaults.standard.data(forKey: key),
//				let label = try? JSONDecoder().decode(ItemLabel.self, from: labelData) {
//				labels.append(label)
//			}
//		}
//		return labels.sorted { b1, b2 in
//			b1.labelName.lowercased() < b2.labelName.lowercased()
//		}
//	}
//
//	// MARK: - Codable Conformance
//	required init(from decoder: Decoder) throws {
//		let container = try decoder.container(keyedBy: CodingKeys.self)
//		id = try container.decode(String.self, forKey: .id)
//		labelName = try container.decode(String.self, forKey: .labelName)
//		let colorData = try container.decode(Data.self, forKey: .labelColor)
//		if let decodedColor = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData) {
//			labelColor = Color(decodedColor)
//		} else {
//			labelColor = Color.clear
//		}
//	}
//
//	func encode(to encoder: Encoder) throws {
//		var container = encoder.container(keyedBy: CodingKeys.self)
//		try container.encode(id, forKey: .id)
//		try container.encode(labelName, forKey: .labelName)
//		let colorData = try NSKeyedArchiver.archivedData(withRootObject: UIColor(labelColor), requiringSecureCoding: false)
//		try container.encode(colorData, forKey: .labelColor)
//	}
//}
