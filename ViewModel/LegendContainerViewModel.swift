//
//  File.swift
//  
//
//  Created by Alidin on 22/08/23.
//

import Foundation
import SwiftUI

class LegendContainerViewModel : ObservableObject{
	@Published var isAddingNew = false
	@Published var newLabelName = ""
	@Published var newLabelColor = Color.white
	
	func saveNewLabel(labels : Binding<[ItemLabel]>){
		let newLabel = ItemLabel(id: UUID().uuidString, labelName: newLabelName, labelColor: newLabelColor)
		newLabel.save()

		newLabelName = ""
		newLabelColor = Color.white
		isAddingNew = false
		
		labels.wrappedValue.append(newLabel)
	}
}
