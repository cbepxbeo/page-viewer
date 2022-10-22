import SwiftUI
import PageViewer

struct RenderWithPointsStyle: View {
    var body: some View {
        PageViewerView(views: [Color.red, Color.yellow])
            .pointsStyle(ExampleStyle())
            .pagePoints(true)
            
    }
}

struct ExampleStyle: PagesViewerPointStyle {
    var opacity: CGFloat? = 0.8
    var padding: CGFloat? = 40
    var borderInactiveColor: Color? = .red
    var bodyInactiveColor: Color? = .yellow
    var bodyActiveColor: Color? = .orange
    var borderActiveColor: Color? = .blue
    var size: CGFloat? = 44
    var borderSize: CGFloat? = 1
    var spacing: CGFloat? = 15
}

struct RenderWithPointsStyle_Previews: PreviewProvider {
    static var previews: some View {
        RenderWithPointsStyle()
    }
}
