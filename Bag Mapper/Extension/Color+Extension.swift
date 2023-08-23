//
//  File.swift
//  
//
//  Created by Alidin on 23/08/23.
//

import Foundation
import SwiftUI

extension Color{
	init(hex: String) {
		let scanner = Scanner(string: hex)
		_ = scanner.scanString("#")
		
		var rgb: UInt64 = 0
		
		scanner.scanHexInt64(&rgb)
		
		let red = Double((rgb & 0xFF0000) >> 16) / 255.0
		let green = Double((rgb & 0x00FF00) >> 8) / 255.0
		let blue = Double(rgb & 0x0000FF) / 255.0
		
		self.init(red: red, green: green, blue: blue)
	}
	
	func toHex() -> String {
		let components = self.cgColor?.components
		let r = UInt8((components?[0] ?? 0.0) * 255)
		let g = UInt8((components?[1] ?? 0.0) * 255)
		let b = UInt8((components?[2] ?? 0.0) * 255)
		
		return String(format: "#%02X%02X%02X", r, g, b)
	}
}
