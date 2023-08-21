//
//  Helper.swift
//
//  Created by Alidin on 16/04/23.
//

import Foundation
import SwiftUI

func clearAllItemsFromUserDefaults() {
	let keys = UserDefaults.standard.dictionaryRepresentation().keys
	for key in keys {
		UserDefaults.standard.removeObject(forKey: key.description)
	}
	UserDefaults.standard.synchronize()
}

func deleteAllImagesFromLocalStorage() -> Bool {
	// Get the file URL for the document directory in local storage
	guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
		return false
	}
	
	// Get all files in the document directory
	do {
		let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil, options: [])
		
		// Loop through each file URL and remove it
		for fileURL in fileURLs {
			try FileManager.default.removeItem(at: fileURL)
		}
		print("All images deleted from local storage")
		return true
	} catch {
		print("Failed to delete all images from local storage: \(error.localizedDescription)")
		return false
	}
}
