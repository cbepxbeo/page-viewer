/*
 
 Project: PageViewer
 File: PageViewRepresentable.swift
 Created by: Egor Boyko
 Date: 24.08.2023
 
 Status: #Complete | #Not decorated
 
 */

import SwiftUI

struct PageViewRepresentable<Content: View>: UIViewControllerRepresentable{
    init(
        views: [Content],
        index: Binding<Int>?,
        looped: Bool,
        delegate: PageViewDelegate? = nil,
        controller: PageViewController? = nil) {
            self.updatedDataHandler = .init()
            self.views = views
            self.index = index
            self.delegate = delegate
            self.controller = controller
            self.looped = looped
        }
    
    let updatedDataHandler: UpdatedDataHandler
    let views: [Content]
    let index: Binding<Int>?
    
    var looped: Bool
    weak var delegate: PageViewDelegate?
    weak var controller: PageViewController?
    
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        context.coordinator.updated(
            pageViewController,
            index: self.index?.wrappedValue,
            coordinator: context.coordinator
        )
    }
}
