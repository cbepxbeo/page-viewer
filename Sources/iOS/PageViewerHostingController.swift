//
// Project: PageViewer
// File: PageViewerHostingController.swift
// Created by: Egor Boyko
// Date: 22.10.2022
//
// Status: #In progress | #Not decorated
//
import SwiftUI

final internal class PageViewerHostingController<Content>: UIHostingController<Content> where Content: View {
    private (set) var index: Int
    internal init(index: Int, rootView: Content) {
        self.index = index
        super.init(rootView: rootView)
    }
    @MainActor required dynamic internal init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
