//
//  File.swift
//  
//
//  Created by Alidin on 16/04/23.
//

import Foundation
import SwiftUI

class ImageHelper{
	
	static func setImageOrientation(image: UIImage, orientation: UIImage.Orientation) -> UIImage? {
		
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
}
