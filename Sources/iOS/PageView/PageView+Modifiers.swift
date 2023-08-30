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
    ///Wraps the view and adds indicator pages according to the style.
    ///- Parameter style: Defines the appearance of the indicators and their position.
    ///- Parameter maxView: Specifies the maximum number of Views at which indicators will be shown,
    /// if the limit is not required, specify nil.
    ///- Note: Specify this modifier last. it returns some View
    @ViewBuilder
    public func indicators<Style: IndicatorStyle>(
        _ style: Style = DefaultIndicatorStyle(),
        maxView: Int? = 10) -> some View {
            if let maxView, self.views.count > maxView {
                self
            } else {
                style.makeConfiguredPageView(content: { AnyView(self) }){
                    AnyView(
                        ForEach(0..<self.views.count, id: \.self){ index in
                            style.makeIndicator(
                                selected: index == self.index.wrappedValue,
                                index: index
                            )
                        }
                    )
                }
            }
    }
}
