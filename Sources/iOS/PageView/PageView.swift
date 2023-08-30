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
            self.externalIndex = index
            self.looped = false
            self.scrollEnabled = true
        }
    
    @State
    var localIndex: Int = 0
    
    weak var delegate: PageViewDelegate? = nil
    weak var controller: PageViewController? = nil
    var looped: Bool = false
    var scrollEnabled: Bool = true
    var views: [Content]
    let externalIndex: Binding<Int>?
    
    var index: Binding<Int> {
        if let externalIndex {
            return externalIndex
        }
        return $localIndex
    }
        
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
