//
//  Color+Extension.swift
//  
//
//  Created by Alidin on 23/08/23.
//

import Foundation
import SwiftUI

extension Color{
	init(hex: String) {
		var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
		hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
		
		var rgb: UInt64 = 0
		
		Scanner(string: hexSanitized).scanHexInt64(&rgb)
		
		let red = Double((rgb & 0xFF0000) >> 16) / 255.0
		let green = Double((rgb & 0x00FF00) >> 8) / 255.0
		let blue = Double(rgb & 0x0000FF) / 255.0
		
		self.init(red: red, green: green, blue: blue)
	}
	
	func toHex() -> String {
		guard let components = self.cgColor?.components else {
			return ""
		}
		
		let r = Int(components[0] * 255.0)
		let g = Int(components[1] * 255.0)
		let b = Int(components[2] * 255.0)
		
		return String(format: "#%02X%02X%02X", r, g, b)
	}

}
