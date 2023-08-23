//
//  ButtonStyleModifier.swift
//  
//
//  Created by Alidin on 21/08/23.
//


import SwiftUI

struct ButtonStyleModifier : ViewModifier{
	var font : Font
	var horizontalPad : CGFloat
	var verticalPad : CGFloat
	var foregroundColor : Color
	var backgroundColor : Color
	var cornerRadius : CGFloat
	
	func body(content: Content) -> some View {
		content.font(font)
			.padding(.vertical, verticalPad)
			.padding(.horizontal, horizontalPad)
			.foregroundColor(foregroundColor)
			.background(backgroundColor)
			.cornerRadius(8)
		}
}
