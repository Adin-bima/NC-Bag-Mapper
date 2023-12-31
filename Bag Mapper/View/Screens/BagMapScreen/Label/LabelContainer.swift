//
//  File.swift
//  
//
//  Created by Alidin on 21/08/23.
//

import Foundation
import SwiftUI

struct LabelContainer : View{
	@EnvironmentObject var mainLayoutViewModel : MainLayoutViewModel

	@Binding var bag : Bag
	@Binding var selectedLabel : String
	
	var body : some View{
		VStack (spacing: 0) {
			Button {
				selectedLabel = ""
			} label: {
				HStack(spacing : 8) {
					
					Image(systemName: "circle.fill").foregroundColor(Color.gray)
					
					Text("All")
						.foregroundColor(Color.black)
					
					Spacer()
					
				}
				.multilineTextAlignment(.leading)
			}
			.padding(4)
			.background(
				selectedLabel == "" ? Color.gray.opacity(0.5) : Color.clear
			)
			.clipShape(
				RoundedRectangle(cornerRadius: 4)
			)
			
			.frame(maxWidth: .infinity	)
			
			ForEach( $mainLayoutViewModel.labels, id:\.id ){
				$label in
				LabelItemView(bag: $bag, label: $label, selectedLabel: $selectedLabel)
			}
		}
		
		
	}
}
