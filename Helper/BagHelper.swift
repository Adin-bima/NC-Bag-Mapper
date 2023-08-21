//
//  File.swift
//  
//
//  Created by Alidin on 17/04/23.
//

import Foundation
import SwiftUI

class BagHelper{
	static func saveImageToLocalStorage(image : UIImage, id : String) -> Bool{
		// Create a UUID as the file name
		let imageName = id
		
		// force orientation to portrait
		let fixedImage = ImageHelper.setImageOrientation(image: image, orientation: .up)
		
		// Convert UIImage to Data
		guard let imageData = fixedImage?.pngData() else {
			return false
		}
		
		// Get the file URL for the local storage
		guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
			return false
		}
		
		let fileURL = documentsDirectory.appendingPathComponent("\(imageName).png")
		
		// Write the Data to file
		do {
			try imageData.write(to: fileURL, options: .atomic)
			print("Image saved to local storage with UUID: \(imageName)")
			return true
		} catch {
			print("Failed to save image to local storage: \(error.localizedDescription)")
			return false
		}
	}
	
	static func deleteImageFromLocalStorage(imageId: String) -> Bool {
		// Get the file URL for the image in local storage
		guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
			return false
		}
		
		let fileURL = documentsDirectory.appendingPathComponent("\(imageId).png")
		
		// Delete the image file from local storage
		do {
			try FileManager.default.removeItem(at: fileURL)
			print("Image deleted from local storage with ID: \(imageId)")
			return true
		} catch {
			print("Failed to delete image from local storage: \(error.localizedDescription)")
			return false
		}
	}
}
