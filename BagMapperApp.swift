import SwiftUI


@main
struct MyApp: App {
	@StateObject var dataContainer : DataContainer = DataContainer()
	var body: some Scene {
		WindowGroup {
			if(dataContainer.setting.isOnboardingDone){
				MainLayoutView()
					.environmentObject(dataContainer)
					.onAppear(){
						dataContainer.bags = Bag.loadAll()
					}
			}else{
				OnboardingView()
					.environmentObject(dataContainer)
					.onAppear(){
						dataContainer.bags = Bag.loadAll()
					}
				
			}
		}
	}
}
