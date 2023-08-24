//
//  OnboardingSectionContainer.swift
//  
//
//  Created by Alidin on 21/08/23.
//

import SwiftUI

struct OnboardingSectionContainer: View {
	var imageName: String
	var title: String
	var description: String
	
	var body: some View {
		VStack(spacing: 16) {
			Image(imageName)
				.resizable()
				.aspectRatio(contentMode: .fit)
				.padding(.horizontal, 32)
				.padding(.vertical, 64)
			
			Text(title)
				.font(.title)
				.fontWeight(.bold)
				.padding(.bottom, 16)
				.padding(.horizontal, 32)
			
			Text(description)
				.font(.body)
				.multilineTextAlignment(.center)
				.padding(.horizontal, 32)
				.foregroundColor(.gray)
			
			Spacer()
			
		}
	}
}
