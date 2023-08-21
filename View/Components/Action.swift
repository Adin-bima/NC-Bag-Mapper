//
//  SwiftUIView.swift
//  
//
//  Created by Alidin on 18/04/23.
//

import SwiftUI

struct Action: View {
	@Binding var scale : CGFloat
	@Binding var lastScale : CGFloat
	@Binding var position : CGPoint
	@Binding var offset : CGSize
	@Binding var lastOffset : CGSize
	
    var body: some View {
		 HStack{
			 Spacer()
			 VStack(alignment : .trailing){
				 Spacer()
				 Button {
					 withAnimation {
						 scale = 1.0
						 lastScale = 1.0
						 position = .zero
						 offset = .zero
						 lastOffset = .zero
					 }
				 } label: {
					 Image(systemName: "viewfinder")
						 .frame(width: 40, height: 40)
						 .foregroundColor(Color.blue)
				 }
				 .background(Color.white)
				 .opacity(0.8)
				 .clipShape(Circle())
				 
				 Button {
					 withAnimation {
						 lastScale = scale
						 scale += 0.3
					 }
				 } label: {
					 Image(systemName: "plus.magnifyingglass")
						 .frame(width: 40, height: 40)
						 .foregroundColor(Color.blue)
				 }
				 .background(Color.white)
				 .opacity(0.8)
				 .clipShape(Circle())
				 
				 Button {
					 withAnimation {
						 lastScale = scale
						 scale -= 0.3
					 }
				 } label: {
					 Image(systemName: "minus.magnifyingglass")
						 .frame(width: 40, height: 40)
						 .foregroundColor(Color.blue)
				 }
				 .background(Color.white)
				 .opacity(0.8)
				 .clipShape(Circle())
			 }
			 .padding(.trailing, 8)
			 .padding(.bottom, 8)
			 
		 }
    }
}


