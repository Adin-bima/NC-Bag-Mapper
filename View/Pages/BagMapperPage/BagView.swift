
//
//  SwiftUIView.swift
//
//
//  Created by Alidin on 17/04/23.
//

import SwiftUI




struct BagView : View{
	@EnvironmentObject var dataContainer: DataContainer
	@Binding var bag : Bag
	@StateObject var bagViewModel = BagViewModel()
	
	
	init(bag: Binding<Bag>) {
		_bag = bag
	}
	
	var body: some View{
		GeometryReader{
			mainGeometry in
			ZStack(){
				ItemMarkerContainer(bagViewModel: bagViewModel, bagId: $bag.id)
				LegendContainer(bag:$bag, selectedLabel: $bagViewModel.selectedLabel, isOpened: $bagViewModel.isLegendOpened, onLabelDeletion : bagViewModel.onLabelDeletion)
				ActionContainer(scale: $bagViewModel.scale, lastScale: $bagViewModel.lastScale, position: $bagViewModel.position, offset: $bagViewModel.offset, lastOffset: $bagViewModel.lastOffset)
			}
			.frame(maxWidth: .infinity, maxHeight : .infinity)
			.contentShape(Rectangle())
			.onAppear(){
				bagViewModel.mainGeometrySize = mainGeometry.size
				bagViewModel.position = CGPoint(
					x: mainGeometry.size.width/2, y: mainGeometry.size.width/2
				)
			}
			
		}
		.ignoresSafeArea(.keyboard)
		.onAppear(){
			bagViewModel.onBagAppear(bag : bag)
		}
		.onChange(of: bag) { newValue in
			bagViewModel.onBagChange(newValue: newValue)
		}
	}
	
	
}
