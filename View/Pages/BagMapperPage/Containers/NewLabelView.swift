//
//  SwiftUIView.swift
//  
//
//  Created by Alidin on 21/08/23.
//

import SwiftUI

struct NewLabelView: View {
	@ObservedObject var legendContainerViewModel : LegendContainerViewModel
	@EnvironmentObject var dataContainer : DataContainer
	
    var body: some View {
		VStack{
			HStack(spacing : 4){
				
				ColorPicker("", selection: $legendContainerViewModel.newLabelColor, supportsOpacity: false)
					.padding()
				
				TextField("Label", text: $legendContainerViewModel.newLabelName)
					.frame(width: 120)
					.textFieldStyle(.roundedBorder)
				
				Button {
					legendContainerViewModel.addNewLabel(dataContainer : dataContainer)
				} label: {
					Image(
						systemName: "checkmark"
					)
					.frame(width: 8)
				}.buttonStyle(.borderedProminent)
				
			}
			
		}.padding(8)
    }
}
