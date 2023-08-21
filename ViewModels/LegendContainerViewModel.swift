//
//  File.swift
//  
//
//  Created by Alidin on 21/08/23.
//a

import Foundation
import SwiftUI

class LegendContainerViewModel : ObservableObject{
	@Published var isAddingNew = false
	@Published var newLabelName = ""
	@Published var newLabelColor = Color.white
	
	func addNewLabel(dataContainer : DataContainer){
		let newLabel = Label(id: UUID().uuidString, labelName: self.newLabelName, labelColor: self.newLabelColor)
		newLabel.save()
		dataContainer.labels.append(newLabel)
		
		self.newLabelName = ""
		self.newLabelColor = Color.white
		
		self.isAddingNew = false
	}
}
