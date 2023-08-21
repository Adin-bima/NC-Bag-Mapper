//
//  SwiftUIView.swift
//  
//
//  Created by Alidin on 21/08/23.
//

import SwiftUI

struct ItemMarkerContainer: View {
	@ObservedObject var bagViewModel : BagViewModel
	@Binding var bag : Bag
	
	var body: some View {
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
											ItemMarkerView(
												item:$item,
												imageSize: $bagViewModel.imageSize,
												zoomScale : $bagViewModel.scale,
												focusedItemId : $bagViewModel.focusedItemId,
												deletedLabelId : $bagViewModel.deletedLabelId,
												onFocused: { item in
													bagViewModel.focusedItemId = item.id
												}
												
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
									let newItem = Item(
										id: UUID().uuidString,
										bagId: bag.id,
										itemName: "New item",
										notes: "",
										x: location.x / geo.size.width,
										y: location.y / geo.size.height
									)
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
	}
}

