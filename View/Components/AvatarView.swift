//
//  File.swift
//  
//
//  Created by Alidin on 17/04/23.
//

import SwiftUI

struct AvatarView: View {
	var image: UIImage
	
	var body: some View {
		Image(uiImage: image)
			.resizable()
			.aspectRatio(contentMode: .fill)
			.frame(width: 50, height: 50)
			.clipShape(RoundedRectangle(cornerRadius: 8)) // Clip the image to a circle shape// Add a white border around the 
			.shadow(radius: 4) // Add a shadow effect
	}
}
