//
//  SwiftUIView.swift
//  
//
//  Created by Alidin on 21/08/23.
//

import SwiftUI

struct ItemMarkerContainer: View {
	@EnvironmentObject var mainLayoutViewModel : MainLayoutViewModel
	
	@ObservedObject var bagMapViewModel : BagMapViewModel
	@StateObject var itemMarkerContainerViewModel = ItemMarkerContainerViewModel()
	@Binding var bag : Bag
	
	var body: some View {
		if let image = bagMapViewModel.image{
			Image(uiImage: image)
				.resizable()
				.aspectRatio(contentMode: .fit)
				.scaleEffect(bagMapViewModel.scale)
				.offset(bagMapViewModel.offset)
				.background(GeometryReader { geo in
					Color.clear
						.preference(key: ImageSizePreferenceKey.self, value: geo.size)
						.onAppear{
							bagMapViewModel.initialImageSize = geo.size
							bagMapViewModel.imageSize = geo.size
						}
				})
				.onPreferenceChange(ImageSizePreferenceKey.self) { imageSize in
					bagMapViewModel.imageSize = imageSize
				}
				.overlay(
					GeometryReader{
						geo in
						Rectangle()
							.fill(Color.clear)
							.contentShape(Rectangle())
							.overlay(
								ZStack{
									ForEach($bagMapViewModel.items, id : \.id){
										$item in
										if( bagMapViewModel.selectedLabel.isEmpty || bagMapViewModel.selectedLabel == item.labelId ){
											ItemMarkerView(
												item:$item,
												imageSize: $bagMapViewModel.imageSize,
												zoomScale : $bagMapViewModel.scale,
												focusedItemId : $bagMapViewModel.focusedItemId,
												deletedLabelId : $bagMapViewModel.deletedLabelId,
												onFocused: { item in
													bagMapViewModel.focusedItemId = item.id
												}
											)
//											.environmentObject(mainLayoutViewModel)
										}
									}
								}
							)
							.frame(width: geo.size.width, height: geo.size.height)
							.onTapGesture(coordinateSpace : .local){
								location in
									itemMarkerContainerViewModel.createNewItem(location: location, geo : geo, bagMapViewModel: bagMapViewModel, bagId: bag.id)
							}
							.scaleEffect(bagMapViewModel.scale)
							.offset(bagMapViewModel.offset)
							.gesture(MagnificationGesture()
								.onChanged { value in
									withAnimation {
										bagMapViewModel.scale = value.magnitude * bagMapViewModel.lastScale
									}
								}
								.onEnded({ value in
									bagMapViewModel.lastScale = bagMapViewModel.scale
								}).simultaneously(
									with:
										DragGesture()
										.onChanged({ value in
											withAnimation {
												bagMapViewModel.offset = CGSize(width: bagMapViewModel.lastOffset.width + value.translation.width,
																			 height: bagMapViewModel.lastOffset.height + value.translation.height)
											}
										})
										.onEnded({ _ in
											bagMapViewModel.lastOffset = bagMapViewModel.offset
										})
								)
									 
							)
					}
				)
		}
	}
}

