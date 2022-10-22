import SwiftUI
import PageViewer

struct RenderWithUsingIndexAndPage: View {
    
    let array: [String] = ["Ex.1", "Ex.2", "Ex.3"]
    
    @State var index: Int = 0
    @State var page: Int = 1
    var body: some View {
        VStack{
            VStack{
                Text("Index: \(index)")
                VStack{
                    PageViewerView(array, currentIndex: $index){ item in
                        ZStack{
                            Color.gray
                            VStack{
                                Text(item)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
                .background(Color.gray)
                .frame(width: 100, height: 50)
                Button("Set new value to index"){
                    self.index = (self.index == (array.count - 1)) ? 0 : self.index + 1
                }
            }
            VStack{
                Text("Page: \(page)")
                VStack{
                    PageViewerView(array, currentPage: $page){ item in
                        ZStack{
                            Color.blue
                            VStack{
                                Text(item)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
                .background(Color.gray)
                .frame(width: 100, height: 50)
                Button("Set new value to page"){
                    self.page = (self.page == (array.count)) ? 1 : self.page + 1
                }
            }
            
            VStack{
                PageViewerView(array, currentIndex: $index){ item in
                    ZStack{
                        Color.yellow
                        VStack{
                            Text(item)
                                .foregroundColor(.white)
                        }
                    }
                }
                .pagePoints(true)
            }
            
        }
    }
}

struct RenderWithUsingIndexAndPage_Previews: PreviewProvider {
    static var previews: some View {
        RenderWithUsingIndexAndPage()
    }
}
