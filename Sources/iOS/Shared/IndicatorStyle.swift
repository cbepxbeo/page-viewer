

import SwiftUI

public protocol IndicatorStyle {
    associatedtype Indicator: View
    func makeIndicator(selected: Bool, index: Int) -> Indicator
}


public struct DefaultStyle: IndicatorStyle {
    public init(){}
    public func makeIndicator(selected: Bool, index: Int) -> some View {
        ZStack{
            Color.red.opacity(selected ? 1: 0.5)
                .animation(.spring(), value: selected)
        }
        .frame(width: 50, height: 50)
    }
}

public struct IndicatorStorage<Content: IndicatorStyle>: View {
    let index: Int
    let selected: Bool
    let content: () -> Content
    public var body: some View {
        content().makeIndicator(selected: selected, index: index)
    }
}





extension PageView {
    

    
    public func indicators<Style: IndicatorStyle, Body: View>(_ style: Style, _ content: (_ content: Self, _ indicators: ForEach<Range<Int>, Int, IndicatorStorage<Style>>) -> Body) -> some View {
        content(
            self,
            ForEach(0..<self.views.count, id: \.self){ item in
                IndicatorStorage(
                    index: item,
                    selected: item == self.index?.wrappedValue) {
                    style
                }
            }
        )
    }
}
