//
//  File.swift
//
//
//  Created by Alidin on 21/08/23.
//

import Foundation
import SwiftUI

extension TextField{
	func primaryStyled()->some View{
		self.modifier(TextFieldStyleModifier(padding: 8, backgroundColor: Color(.systemBackground), corderRadius: 8, strokeColor: AppColor.LIGHT_GRAY, strokeWidth: 1))
	}
}
