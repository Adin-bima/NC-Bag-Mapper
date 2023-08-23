//
//  DatHelper.swift
//
//  Created by Alidin on 16/04/23.
//

import SwiftUI

func deleteAllItemsFromUserDefaults() {
	let keys = UserDefaults.standard.dictionaryRepresentation().keys
	for key in keys {
		UserDefaults.standard.removeObject(forKey: key.description)
	}
	UserDefaults.standard.synchronize()
}

