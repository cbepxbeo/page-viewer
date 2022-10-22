import SwiftUI

@main
struct ExampleProjectApp: App {
    
    static let app = NavigationView {
        List {
            NavigationLink(destination: RenderFromViews()) {
                Text("Render From Views")
            }
            NavigationLink(destination: RenderFromViewsWithPoints()) {
                Text("Render From Views with points")
            }
            NavigationLink(destination: RenderFromBuilder()) {
                Text("Render From Builder")
            }
            NavigationLink(destination: RenderWithUsingIndexAndPage()) {
                Text("Render with using index and number page")
            }
            NavigationLink(destination: RenderWithPointsStyle()) {
                Text("Render with points style")
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ExampleProjectApp.app
        }
    }
}

struct App_Previews: PreviewProvider {
    static var previews: some View {
        ExampleProjectApp.app
    }
}
