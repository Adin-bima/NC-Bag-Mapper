//
//  File.swift
//  
//
//  Created by Alidin on 21/08/23.
//

import Foundation
import SwiftUI

struct TextFieldStyleModifier : ViewModifier{
	
	var padding : CGFloat
	var backgroundColor : Color
	var corderRadius : CGFloat
	var strokeColor : Color
	var strokeWidth : CGFloat
	
	func body(content: Content) -> some View {
		content
			.padding(padding)
			.background(backgroundColor)
			.cornerRadius(corderRadius)
			.overlay(
				RoundedRectangle(cornerRadius: corderRadius)
					.stroke(strokeColor, lineWidth: strokeWidth) // Add a stroke with the primary color
			)
	}
}


