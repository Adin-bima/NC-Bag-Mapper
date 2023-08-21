
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
				if let image = bagViewModel.image{
					Image(uiImage: image)
						.resizable()
						.aspectRatio(contentMode: .fit)
						.scaleEffect(bagViewModel.scale)
						.offset(bagViewModel.offset)
						.background(GeometryReader { geo in
							Color.clear
								.preference(key: ImageSizePreferenceKey.self, value: geo.size)
								.onAppear{
									bagViewModel.initialImageSize = geo.size
									bagViewModel.imageSize = geo.size
								}
						})
						.onPreferenceChange(ImageSizePreferenceKey.self) { imageSize in
							bagViewModel.imageSize = imageSize
						}
						.overlay(
							GeometryReader{
								geo in
								Rectangle()
									.fill(Color.clear)
									.contentShape(Rectangle())
									.overlay(
										ZStack{
											ForEach($bagViewModel.items, id : \.id){
												$item in
												if( bagViewModel.selectedLabel.isEmpty || bagViewModel.selectedLabel == item.labelId ){
													ItemMarkerView(item:$item, imageSize: $bagViewModel.imageSize, zoomScale : $bagViewModel.scale ,focusedItemId : $bagViewModel.focusedItemId, onFocused: { item in
														bagViewModel.focusedItemId = item.id
													},
														   deletedLabelId : $bagViewModel.deletedLabelId
															
													
													)
												}
											}
										}
									)
									.frame(width: geo.size.width, height: geo.size.height)
									.onTapGesture(coordinateSpace : .local){
										location in
										if(bagViewModel.isLegendOpened){
											withAnimation {
												bagViewModel.isLegendOpened.toggle()
											}
										}else{
											let newItem = Item(id: UUID().uuidString, bagId: bag.id, itemName: "New item", notes: "", x: location.x / geo.size.width , y: location.y / geo.size.height)
											newItem.labelId = bagViewModel.selectedLabel
											newItem.save()
											bagViewModel.items.append(newItem)
										}
									}
									.scaleEffect(bagViewModel.scale)
									.offset(bagViewModel.offset)
									.gesture(MagnificationGesture()
										.onChanged { value in
											withAnimation {
												bagViewModel.scale = value.magnitude * bagViewModel.lastScale
											}
										}
										.onEnded({ value in
											bagViewModel.lastScale = bagViewModel.scale
										}).simultaneously(
											with:
												DragGesture()
												.onChanged({ value in
													withAnimation {
														bagViewModel.offset = CGSize(width: bagViewModel.lastOffset.width + value.translation.width,
																					 height: bagViewModel.lastOffset.height + value.translation.height)
													}
												})
												.onEnded({ _ in
													bagViewModel.lastOffset = bagViewModel.offset
												})
										)
												
									)
							}
						)
				}
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
