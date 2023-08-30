/*
 
 Project: PageViewer
 File: PageView+Modifiers.swift
 Created by: Egor Boyko
 Date: 25.08.2023
 
 Status: #Complete | #Not decorated
 
 */

import SwiftUI

extension PageView {
    public func delegate(_ value: PageViewDelegate?) -> Self {
        var view = self
        view.delegate = value
        return view
    }
    public func controller(_ value: PageViewController?) -> Self {
        var view = self
        view.controller = value
        return view
    }
    public func scrollEnabled(_ value: Bool) -> Self {
        var view = self
        view.scrollEnabled = value
        return view
    }
    public func looped(_ value: Bool) -> Self {
        var view = self
        view.looped = value
        return view
    }
    
    public func indicators<Style: IndicatorStyle>(_ style: Style) -> some View {
        style.makeConfiguredPageView(content: { AnyView(self) }){
            AnyView(
                ForEach(0..<self.views.count, id: \.self){ index in
                    style.makeIndicator(
                        selected: index == self.index?.wrappedValue,
                        index: index
                    )
                }
            )
        }
    }
    
    
    
    //    public func indicators<Style: IndicatorStyle, Body: View>(
    //        _ style: Style,
    //        _ content: (
    //            _ content: Self,
    //            _ indicators: IndicatorsConfiguration<Style>
    //        ) -> Body) -> some View {
    //        content(
    //            self,
    //            IndicatorsConfiguration(
    //                range: 0..<self.views.count,
    //                index: self.index?.wrappedValue,
    //                style: { style }
    //            )
    //        )
    //    }
}
struct Configuration<Style: IndicatorStyle>: View {
    let range: Range<Int>
    let index: Int?
    let style: () -> Style
    public var body: some View {
        ForEach(range, id: \.self){ index in
            IndicatorStorage(
                index: index,
                selected: index == self.index,
                style: style
            )
        }
    }
}
