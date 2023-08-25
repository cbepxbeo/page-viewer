/*
 
 Project: PageViewer
 File: Hosting.swift
 Created by: Egor Boyko
 Date: 26.08.2023
 
 Status: #Complete | #Not decorated
 
 */

import SwiftUI

final internal class Hosting<Content: View>: UIHostingController<Content> {
    private (set) var index: Int
    internal init(index: Int, rootView: Content) {
        self.index = index
        super.init(rootView: rootView)
        self.view.backgroundColor = .clear
    }
    @MainActor required dynamic internal init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
