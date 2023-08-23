//
//  Item.swift
//  
//
//  Created by Alidin on 16/04/23.
//


struct Item: Equatable, Codable, Identifiable {
	var id: String
	var bagId: String
	var labelId: String = ""
	var itemName: String
	var notes: String
	var isFavorite: Bool = false
	var isHidden: Bool = false
	var x: Double = 0
	var y: Double = 0
	
	static func == (lhs: Item, rhs: Item) -> Bool {
		return lhs.id == rhs.id
	}
	
}


//struct Item : Codable, Equatable{
//	var id : String
//	var bagId : String
//	var labelId : String = ""
//	var itemName : String
//	var notes : String
//	var isFavorite : Bool = false
//	var isHidden : Bool = false
//	var x : Double = 0
//	var y : Double = 0
//
//	static func == (lhs: Item, rhs: Item) -> Bool {
//		return lhs.id == rhs.id
//	}
//
//	enum CodingKeys: String, CodingKey {
//		case id
//		case bagId
//		case itemName
//		case notes
//		case isFavorite
//		case isHidden
//		case labelId
//		case x
//		case y
//	}
//
//	init(id: String, bagId : String, itemName: String, notes: String, x : Double, y:Double) {
//		self.id = id
//		self.itemName = itemName
//		self.notes = notes
//		self.x = x
//		self.y = y
//		self.bagId = bagId
//	}
//
//	// MARK: relations
//
//	func bag()->Bag?{
//		if let bag = Bag.load(id: bagId){
//			return bag
//		}
//		return nil
//	}
//
//	func label()->ItemLabel?{
//		if let label = ItemLabel.load(id: labelId){
//			return label
//		}
//		return nil
//	}
//
//	// MARK: crud operatiorn
//
//	func save() {
//		do {
//			let itemData = try JSONEncoder().encode(self)
//			UserDefaults.standard.set(itemData, forKey: "item_\(id)")
//		} catch {
//			print("Error encoding Item object: \(error.localizedDescription)")
//		}
//	}
//
//	static func load(id: String) -> Item? {
//		if let itemData = UserDefaults.standard.data(forKey: "item_\(id)"),
//			let item = try? JSONDecoder().decode(Item.self, from: itemData) {
//			return item
//		}
//		return nil
//	}
//
//	func delete() {
//		UserDefaults.standard.removeObject(forKey: "item_\(id)")
//	}
//
//	static func loadAll() -> [Item] {
//		var items: [Item] = []
//		let keys = UserDefaults.standard.dictionaryRepresentation().keys
//		for key in keys {
//			if key.hasPrefix("item_"),
//				let bagData = UserDefaults.standard.data(forKey: key),
//				let bag = try? JSONDecoder().decode(Item.self, from: bagData) {
//				items.append(bag)
//			}
//		}
//		return items.sorted { b1, b2 in
//			b1.itemName.lowercased() < b2.itemName.lowercased()
//		}
//	}
//
//	required init(from decoder: Decoder) throws {
//		let container = try decoder.container(keyedBy: CodingKeys.self)
//		id = try container.decode(String.self, forKey: .id)
//		bagId = try container.decode(String.self, forKey: .bagId)
//		itemName = try container.decode(String.self, forKey: .itemName)
//		notes = try container.decode(String.self, forKey: .notes)
//		isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
//		isHidden = try container.decode(Bool.self, forKey: .isHidden)
//		labelId = try container.decode(String.self, forKey: .labelId)
//		x = try container.decode(Double.self, forKey: .x)
//		y = try container.decode(Double.self, forKey: .y)
//	}
//
//	func encode(to encoder: Encoder) throws {
//		var container = encoder.container(keyedBy: CodingKeys.self)
//		try container.encode(id, forKey: .id)
//		try container.encode(bagId, forKey: .bagId)
//		try container.encode(itemName, forKey: .itemName)
//		try container.encode(notes, forKey: .notes)
//		try container.encode(isFavorite, forKey: .isFavorite)
//		try container.encode(isHidden, forKey: .isHidden)
//		try container.encode(labelId, forKey: .labelId)
//		try container.encode(x, forKey: .x)
//		try container.encode(y, forKey: .y)
//	}
//}
