//
// Project: PageViewer
// File: PageViewerUIWrapper.swift
// Created by: Egor Boyko
// Date: 22.10.2022
//
// Status: #In progress | #Not decorated
//
import SwiftUI
import OSLog

internal struct PageViewerUIWrapper<T>: UIViewControllerRepresentable where T : View{
    
    private let logger: Logger
    private let views: [T]
    private let currentIndex: Binding<Int>?
    private let currentPage: Binding<Int>?
    private let pointsPage: Binding<Int>
    private let forceMoveToNextPoint: Bool
    private let isInfiniteScrolled: Bool
    
    internal init(_ forceMoveToNextPoint: Bool, _ views: [T], _ currentIndex: Binding<Int>?, _ currentPage: Binding<Int>?, _ pointsPage: Binding<Int>, _ isInfiniteScrolled: Bool) {
        self.views = views
        self.currentIndex = currentIndex
        self.currentPage = currentPage
        self.pointsPage = pointsPage
        self.forceMoveToNextPoint = forceMoveToNextPoint
        self.isInfiniteScrolled = isInfiniteScrolled
        self.logger = .init(subsystem: "page-viewer", category: "page-viewer-ui-wrapper")
    }
    
    internal func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator
        if let root = context.coordinator.root {
            pageViewController.setViewControllers(
                [root], direction: .forward, animated: true)
        }
        return pageViewController
    }
    
    internal func makeCoordinator() -> PagesViewerCoordinator<T> {
        PagesViewerCoordinator(forceMoveToNextPoint, views, currentIndex, currentPage, pointsPage, isInfiniteScrolled)
    }
    
    internal func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        
        let lastIndex: Int,
            controllerCount: Int,
            navigationDirection: UIPageViewController.NavigationDirection
        
        var currentIndex: Int
        
        
        if let index = self.currentIndex?.wrappedValue {
            currentIndex = index
        } else if let page = self.currentPage?.wrappedValue {
            currentIndex = page - 1
        } else {
            return
        }
        
        
        controllerCount = context.coordinator.controllers.count
        lastIndex = context.coordinator.lastIndex
        
        
        
        print("КОН: изменения")
        if context.coordinator.firstUpdate {
            if currentIndex >= controllerCount && lastIndex < controllerCount  {
                logger.warning("index or page number out of range")
                DispatchQueue.main.async {
                    self.currentPage?.wrappedValue = 1
                    self.currentIndex?.wrappedValue = 0
                    context.coordinator.firstUpdate = false
                }
                currentIndex = 0
            }
        }
        

        
        if context.coordinator.currentIndex?.wrappedValue != currentIndex {
            DispatchQueue.main.async {
                context.coordinator.currentIndex?.wrappedValue = currentIndex
            }
        }
        
        if context.coordinator.pointsPage.wrappedValue != currentIndex {
            DispatchQueue.main.async {
                context.coordinator.pointsPage.wrappedValue = currentIndex
            }
        }
        
        if lastIndex == currentIndex { return }
        
        navigationDirection = currentIndex > lastIndex ? .forward : .reverse
        
        DispatchQueue.main.async {
            context.coordinator.lastIndex = currentIndex
            pageViewController.setViewControllers(
                [context.coordinator.controllers[currentIndex]], direction: navigationDirection, animated: true)
            
        }

    }

}
