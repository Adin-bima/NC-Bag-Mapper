//
//  SwiftUIView.swift
//  
//
//  Created by Alidin on 17/04/23.
//

import SwiftUI

struct LegendContainer: View {
	@EnvironmentObject var dataContainer : DataContainer
	@StateObject var legendContainerViewModel = LegendContainerViewModel()
	
	@Binding var bag : Bag
	@Binding var selectedLabel : String
	@Binding var isOpened : Bool
	
	@GestureState var dragOffset = CGSize.zero
	
	var onLabelDeletion : (_ : String, _ : Bag)->Void
	
	var body: some View {
		HStack(alignment : .center, spacing: 0){
			Spacer()
			
			Button {
				withAnimation(.easeOut){
					self.isOpened.toggle()
				}
			} label: {
				Image(systemName: isOpened ? "chevron.right" : "chevron.left")
					.frame(width: 32, height: 40)
					.foregroundColor(Color.black)
			}
			.frame(height: 80)
			.background(Color.white)
			.cornerRadius(8)
			.padding(.top, 8)
			.padding(.trailing, 8)
			.opacity(0.8)
			.offset( CGSize(width: dragOffset.width, height: 0) )
			
			if(isOpened ){
				LabelContainer(legendContainerViewModel: legendContainerViewModel, bag : $bag, selectedLabel:$selectedLabel, isOpened : $isOpened, onLabelDeletion: onLabelDeletion)
				
				
			}
			
		
		}
	}
}
//
//struct Legend_Previews: PreviewProvider {
//	static var previews: some View {
//		Legend()
//	}
//}
