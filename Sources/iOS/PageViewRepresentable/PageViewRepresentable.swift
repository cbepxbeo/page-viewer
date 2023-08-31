/*
 
 Project: PageViewer
 File: PageViewRepresentable.swift
 Created by: Egor Boyko
 Date: 24.08.2023
 
 Status: #Completed | #Not required
 
 */

import SwiftUI

struct PageViewRepresentable<Content: View>: UIViewControllerRepresentable, Logging{
    let views: [Content]
    let index: Binding<Int>?
    let scrollEnabled: Bool
    let looped: Bool
    weak var delegate: PageViewDelegate?
    weak var controller: PageViewController?
    
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        self.updateCoordinator(pageViewController, context)
        context.coordinator.updated(
            pageViewController,
            index: self.index?.wrappedValue,
            coordinator: context.coordinator
        )
    }
}
