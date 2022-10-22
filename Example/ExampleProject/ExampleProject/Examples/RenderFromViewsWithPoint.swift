import SwiftUI
import PageViewer

struct RenderFromViewsWithPoints: View {
    let views: [Color] = [
        .gray,
        .green,
        .yellow,
        .orange
    ]
    
    var body: some View {
        ZStack{
            Color.yellow
            PageViewerView(views: views)
                .pagePoints(true) //default false
                .pointPosition(.top) //default bottom
                .pointPadding(50) //default 10
                .forceMove(true) //default true
        }
    }
}

struct RenderFromViewsWithPoints_Previews: PreviewProvider {
    static var previews: some View {
        RenderFromViewsWithPoints()
    }
}
