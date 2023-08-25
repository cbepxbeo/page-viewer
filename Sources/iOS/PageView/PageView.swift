/*
 
 Project: PageViewer
 File: PageView.swift
 Created by: Egor Boyko
 Date: 24.08.2023
 
 Status: #Complete | #Not decorated
 
 */

import SwiftUI

public struct PageView<Collection: RandomAccessCollection, Content: View>: View {
    init(
        index: Binding<Int>?,
        looped: Bool,
        delegate: PageViewDelegate?,
        controller: PageViewController?,
        views: [Content]) {
            self.delegate = delegate
            self.controller = controller
            self.views = views
            self.index = index
            self.looped = looped
        }
    weak var delegate: PageViewDelegate?
    weak var controller: PageViewController?
    var looped: Bool
    var views: [Content]
    let index: Binding<Int>?
    
    public var body: some View {
        PageViewRepresentable(
            views: self.views,
            index: self.index,
            looped: self.looped,
            delegate: self.delegate,
            controller: self.controller
        )
        .ignoresSafeArea()
    }
}
