
//
//  SwiftUIView.swift
//
//
//  Created by Alidin on 17/04/23.
//

import SwiftUI


struct BagMapView : View{
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
				ItemMarkerContainer(bagViewModel: bagViewModel, bag: $bag)
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
			
			bagViewModel.image = bag.getImage()
			bagViewModel.items = bag.items()
//			print(self.items.count)
		}
		.onChange(of: bag) { newValue in
			

			bagViewModel.image = newValue.getImage()
			bagViewModel.items = newValue.items()
			
			bagViewModel.scale = 1.0
			bagViewModel.lastScale = 1.0
			bagViewModel.position  = .zero
			bagViewModel.offset = .zero
			bagViewModel.lastOffset = .zero
			bagViewModel.lastPosition = .zero
			
		}
	}
	
	
}
