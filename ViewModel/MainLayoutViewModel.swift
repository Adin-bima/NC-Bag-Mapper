//
//  File.swift
//  
//
//  Created by Alidin on 22/08/23.
//

import Foundation

class MainLayoutViewModel:ObservableObject{
	@Published var selectedBagId : String = ""
	@Published var isShowingAddBagModal = false
}
