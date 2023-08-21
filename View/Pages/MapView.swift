//
//  SwiftUIView.swift
//  
//
//  Created by Alidin on 16/04/23.
//

import SwiftUI


struct MapView: View {
	@EnvironmentObject var dataContainer : DataContainer
	
	@Binding var selectedBagId : String
	
    var body: some View {
		 Text("No bag selected")
		
    }
}

@available(macCatalyst 16.0, iOS 16.0, macOS 13.0,  *)
struct MapView_Previews: PreviewProvider {
	@State static var selectedBagId = ""
    static var previews: some View {
		 MapView(selectedBagId : $selectedBagId)
    }
}
