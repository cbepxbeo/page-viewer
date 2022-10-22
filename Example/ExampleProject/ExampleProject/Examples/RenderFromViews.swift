import SwiftUI
import PageViewer

struct RenderFromViews: View {
    
    let views: [Color] = [
        .gray,
        .green,
        .yellow,
        .orange
    ]
    
    var body: some View {
        PageViewerView(views: views)
            .ignoresSafeArea()
    }
}

struct RenderFromViews_Previews: PreviewProvider {
    static var previews: some View {
        RenderFromViews()
    }
}
