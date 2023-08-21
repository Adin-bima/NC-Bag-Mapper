//
//  File.swift
//  
//
//  Created by Alidin on 21/08/23.
//

import Foundation
import SwiftUI

extension Text{
	func primaryButtonStyled() -> some View{
		self.modifier(ButtonStyleModifier(font: .headline, horizontalPad: 32, verticalPad: 16, foregroundColor: Color.white, backgroundColor: Color.teal, cornerRadius: 8))
	}
	
	func primaryButtonLineStyled() -> some View{
		self.modifier(ButtonStyleModifier(font: .headline, horizontalPad: 32, verticalPad: 16, foregroundColor: Color.teal, backgroundColor: Color.clear, cornerRadius: 8))
			.clipShape(RoundedRectangle(cornerRadius: 8))
			.overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.teal, lineWidth: 1))
	}
}
