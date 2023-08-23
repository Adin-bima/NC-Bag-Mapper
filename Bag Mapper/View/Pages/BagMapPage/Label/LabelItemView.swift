//
//  SwiftUIView.swift
//  
//
//  Created by Alidin on 21/08/23.
//

import SwiftUI

struct LabelItemView: View {
	@EnvironmentObject var mainLayoutViewModel : MainLayoutViewModel
	
	@Binding var bag : Bag
	@Binding var label : ItemLabel
	@Binding var selectedLabel : String
	
    var body: some View {
		Button {
			selectedLabel = label.id
		} label: {
			HStack(spacing : 8) {
				
				Image(systemName: "circle.fill").foregroundColor(Color(hex: label.labelColor))
				
				Text("\(label.labelName)")
					.foregroundColor(Color.black)
				
				Spacer()
				
				Image(systemName: "trash").onTapGesture {
					_ = ItemLabelService.shared.deleteItemLabelById(label.id)
					mainLayoutViewModel.loadAllLabels()
				}
				.foregroundColor(Color.red)
			}
			.multilineTextAlignment(.leading)
		}
		.padding(4)
		.background(
			selectedLabel == label.id ? Color(hex : label.labelColor).opacity(0.5) : Color.clear
		)
		.clipShape(
			RoundedRectangle(cornerRadius: 4)
		)
		.frame(maxWidth: .infinity	)
    }
}

