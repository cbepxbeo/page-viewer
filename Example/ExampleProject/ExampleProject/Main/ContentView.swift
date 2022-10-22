import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
