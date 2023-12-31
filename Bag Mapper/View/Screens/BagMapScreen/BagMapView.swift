
//
//  BagMapView.swift
//
//
//  Created by Alidin on 17/04/23.
//

import SwiftUI


struct BagMapView : View{
	@EnvironmentObject var mainLayoutViewModel : MainLayoutViewModel
	@Environment(\.horizontalSizeClass) var horizontalSizeClass
	
	@StateObject var bagMapViewModel = BagMapViewModel()
	
	@Binding var bag : Bag
	
	var body: some View{
		GeometryReader{
			mainGeometry in
			ZStack(){
				ItemMarkerContainer(bagMapViewModel: bagMapViewModel, bag: $bag)
				
				LegendContainer(
					bag:$bag,
					selectedLabel: $bagMapViewModel.selectedLabel,
					isOpened: $bagMapViewModel.isLegendOpened
				)
				
				ActionContainer(
					scale: $bagMapViewModel.scale,
					lastScale: $bagMapViewModel.lastScale,
					position: $bagMapViewModel.position,
					offset: $bagMapViewModel.offset,
					lastOffset: $bagMapViewModel.lastOffset
				)
			}
			.frame(maxWidth: .infinity, maxHeight : .infinity)
			.contentShape(Rectangle())
			.onAppear(){
				bagMapViewModel.mainGeometrySize = mainGeometry.size
				bagMapViewModel.position = CGPoint(
					x: mainGeometry.size.width/2, y: mainGeometry.size.width/2
				)
			}
			
		}
		.ignoresSafeArea(.keyboard)
		.onAppear(){
			bagMapViewModel.loadBagComponents(bagId: bag.id)
			
		}
		.onChange(of: bag) { newBagValue in
			bagMapViewModel.changeBagSelection(newBagValue: newBagValue)
		}
		.navigationBarHidden(horizontalSizeClass == .compact ? false : true)
		.navigationTitle(bag.bagName)
	
		
	}
	
	
}
