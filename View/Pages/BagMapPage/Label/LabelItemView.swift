//
//  SwiftUIView.swift
//  
//
//  Created by Alidin on 21/08/23.
//

import SwiftUI

struct LabelItemView: View {
	@EnvironmentObject var dataContainer : DataContainer
	
	@Binding var bag : Bag
	@Binding var label : ItemLabel
	@Binding var selectedLabel : String
	
	var onLabelDeletion : (_ : String, _ : Bag)->Void
	
    var body: some View {
		Button {
			selectedLabel = label.id
		} label: {
			HStack(spacing : 8) {
				
				Image(systemName: "circle.fill").foregroundColor(label.labelColor)
				
				Text("\(label.labelName)")
					.foregroundColor(Color.black)
				
				Spacer()
				
				Image(systemName: "trash").onTapGesture {
					label.delete()
					onLabelDeletion(label.id, bag)
					dataContainer.labels = dataContainer.labels.filter({ originalLabel in
						return originalLabel.id != label.id
					})
				}
				.foregroundColor(Color.red)
			}
			.multilineTextAlignment(.leading)
		}
		.padding(4)
		.background(
			selectedLabel == label.id ? label.labelColor.opacity(0.5) : Color.clear
		)
		.clipShape(
			RoundedRectangle(cornerRadius: 4)
		)
		.frame(maxWidth: .infinity	)
    }
}

