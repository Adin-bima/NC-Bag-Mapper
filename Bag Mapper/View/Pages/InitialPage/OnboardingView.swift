//
//  OnboardingView.swift
//
//
//  Created by Alidin on 21/06/23.
//


import SwiftUI


struct OnboardingView: View {
	
	@State var selectedTab = 0
	
	var body: some View {
		NavigationStack{
			VStack{
				TabView (selection : $selectedTab) {
					VStack{
						
						OnboardingSectionContainer(imageName: AppImage.ICON_MAIN, title: "Welcome to BagMapper!", description: "Effortlessly organize your bag with BagMapper! Tap on the bag image to add markers for your items.")
						
						Button(action: {
							withAnimation {
								selectedTab += 1
							}
						}, label: {
							Text("Next")
								.primaryButtonLineStyled()
								
						})
						.padding(.bottom, 48)
						
					}.tag(0)
					
					VStack{
						
						OnboardingSectionContainer(imageName: AppImage.TAP_BAG, title: "Map Your Items with Precision", description: "Snap a photo of your bag, then tap any location to add marker where you put your item. Say goodbye to searching and hello to precise organization!")
						Button(action: {
							withAnimation {
								selectedTab += 1
							}
						}, label: {
							Text("Next")
								.primaryButtonLineStyled()
								
						})
						
						.padding(.bottom, 48)
						
					}.tag(1)
					
					VStack{
						OnboardingSectionContainer(imageName: AppImage.LOCATION, title: "Find Your Items in a Snap", description: "Quickly locate your items with BagMapper's step-by-step locator. No more rummaging through your bag - find your items with ease!")
						
						NavigationLink {
							MainLayout()
						} label: {
							Text("Get Started")
								.primaryButtonStyled()
						}
						.padding(.bottom, 48)
						
					}.tag(2)
				}
				.tabViewStyle(PageTabViewStyle())
				.indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
			}
			.navigationBarBackButtonHidden(true) // Hide the back button
			.navigationBarItems(trailing: Button(action: {
				
			}, label: {
				NavigationLink{
					MainLayout()
				}label :{
					
					HStack(spacing: 4) {
						Text("Skip")
							.foregroundColor(.teal)
						Image(systemName: "chevron.right")
							.foregroundColor(.teal)
					}
				}
			}))
		}
		
	}
}


