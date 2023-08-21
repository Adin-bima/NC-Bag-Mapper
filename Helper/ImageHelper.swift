//
//  File.swift
//  
//
//  Created by Alidin on 16/04/23.
//

import Foundation
import SwiftUI

struct ImageSizePreferenceKey: PreferenceKey {
	static var defaultValue: CGSize = .zero
	
	static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
		value = nextValue()
	}
}


func setImageOrientation(image: UIImage, orientation: UIImage.Orientation) -> UIImage? {
	
	UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
	
	// redraw the image
	let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
	
	image.draw(in: rect)
	
	guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
		UIGraphicsEndImageContext()
		return nil
	}
	
	// set the new orientation
	UIGraphicsEndImageContext()
	return UIImage(cgImage: newImage.cgImage!, scale: image.scale, orientation: orientation)
}

func saveImageToLocalStorage(image : UIImage, id : String) -> Bool{
	// Create a UUID as the file name
	let imageName = id
	
	// force orientation to portrait
	let fixedImage = setImageOrientation(image: image, orientation: .up)
	
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

func deleteImageFromLocalStorage(imageId: String) -> Bool {
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

