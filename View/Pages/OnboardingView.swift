import SwiftUI


@available(macCatalyst 16.0, iOS 16.0, macOS 13.0,  *)
struct OnboardingView: View {
	
	@State var selectedTab = 0
	var body: some View {
		NavigationStack{
			VStack{
				TabView (selection : $selectedTab) {
					VStack{
						
						OnboardingContainerSectionView(imageName: "iconMain", title: "Welcome to BagMapper!", description: "Effortlessly organize your bag with BagMapper! Tap on the bag image to add markers for your items.")
						Button(action: {
							withAnimation {
								selectedTab += 1
							}
						}, label: {
							Text("Next")
								.font(.headline)
								.padding(.vertical, 16)
								.padding(.horizontal, 32)
						})
						.foregroundColor(.teal)
						.cornerRadius(8)
						.clipShape(RoundedRectangle(cornerRadius: 8))
						.overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.teal, lineWidth: 1))
						.padding(.bottom, 48)
					}.tag(0)
					
					VStack{
						
						OnboardingContainerSectionView(imageName: "tapBag", title: "Map Your Items with Precision", description: "Snap a photo of your bag, then tap any location to add marker where you put your item. Say goodbye to searching and hello to precise organization!")
						Button(action: {
							withAnimation {
								selectedTab += 1
							}
						}, label: {
							Text("Next")
								.font(.headline)
								.foregroundColor(.teal)
								.padding(.vertical, 16)
								.padding(.horizontal, 32)
						})
						.foregroundColor(.teal)
						.cornerRadius(8)
						.clipShape(RoundedRectangle(cornerRadius: 8))
						.overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.teal, lineWidth: 1))
						.padding(.bottom, 48)
					}.tag(1)
					
					VStack{
						OnboardingContainerSectionView(imageName: "location", title: "Find Your Items in a Snap", description: "Quickly locate your items with BagMapper's step-by-step locator. No more rummaging through your bag - find your items with ease!")
						
						NavigationLink {
							MainLayout()
						} label: {
							Text("Get Started")
								.font(.headline)
								.foregroundColor(.white)
								.padding(.vertical, 16)
								.padding(.horizontal, 32)
								.background(Color.teal)
								.cornerRadius(8)
						}
						.padding(.bottom, 48)
					}.tag(2)
				}
				.tabViewStyle(PageTabViewStyle())
				.indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
			}
			//			.navigationBarHidden(true) // Hide the navigation bar
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


@available(macCatalyst 16.0, iOS 16.0, macOS 13.0,  *)
struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		OnboardingView()
	}
}
