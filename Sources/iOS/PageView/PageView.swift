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
        views: [Content]) {
            self.delegate = nil
            self.controller = nil
            self.views = views
            self.index = index
            self.looped = false
            self.scrollEnabled = true
        }
    weak var delegate: PageViewDelegate?
    weak var controller: PageViewController?
    var looped: Bool
    var scrollEnabled: Bool
    var views: [Content]
    let index: Binding<Int>?
        
    public var body: some View {
        PageViewRepresentable(
            views: self.views,
            index: self.index,
            scrollEnabled: self.scrollEnabled,
            looped: self.looped,
            delegate: self.delegate,
            controller: self.controller
        )
        .ignoresSafeArea()
    }
}
