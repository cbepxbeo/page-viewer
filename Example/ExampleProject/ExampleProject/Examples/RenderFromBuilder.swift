import SwiftUI
import PageViewer

struct RenderFromBuilder: View {
    
    let array: [(color: Color, text: String)] = [
        (.green, "Green color"),
        (.red, "Red color"),
        (.yellow, "Yellow color")
    ]
    
    var body: some View {
        VStack(spacing: 0){
            
            PageViewerView(Array(array.reversed())){ index, element in //with index
                ZStack{
                    element.color
                    VStack{
                        Text("Element text: \(element.text)")
                        Text("Index: \(index)")
                    }
                    
                }
            }
            
            PageViewerView(array){ element in //not index
                ZStack{
                    Color.gray
                    ZStack{
                        element.color
                        VStack{
                            Text("Element text: \(element.text)")
                        }
                    }
                    .padding(10)
                }
            }
            
        }
        .ignoresSafeArea()
    }
}

struct RenderFromBuilder_Previews: PreviewProvider {
    static var previews: some View {
        RenderFromBuilder()
    }
}
