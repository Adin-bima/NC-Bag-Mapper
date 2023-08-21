import SwiftUI


@main
struct BagMapperApp: App {
	@StateObject var dataContainer : DataContainer = DataContainer()
	
	
	
	var body: some Scene {
		WindowGroup {
			if(dataContainer.setting.isOnboardingDone){
				MainLayout()
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
