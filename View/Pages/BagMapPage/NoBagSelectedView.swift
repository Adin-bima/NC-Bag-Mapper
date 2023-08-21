//
//  SwiftUIView.swift
//  
//
//  Created by Alidin on 16/04/23.
//

import SwiftUI


struct NoBagSelectedView: View {
	
	var body: some View {
		VStack{
			Image("iconAsk")
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(width: 128)
				.padding(24)
			Text("No bag selected")
		}
		
	}
}

