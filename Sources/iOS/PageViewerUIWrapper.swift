//
// Project: PageViewer
// File: PageViewerUIWrapper.swift
// Created by: Egor Boyko
// Date: 22.10.2022
//
// Status: #In progress | #Not decorated
//
import SwiftUI

internal struct PageViewerUIWrapper<T>: UIViewControllerRepresentable where T : View{
    
    private let views: [T]
    private let currentIndex: Binding<Int>?
    private let currentPage: Binding<Int>?
    internal let pointsPage: Binding<Int>
    private let forceMoveToNextPoint: Bool
    
    internal init(_ forceMoveToNextPoint: Bool, _ views: [T], _ currentIndex: Binding<Int>?, _ currentPage: Binding<Int>?, _ pointsPage: Binding<Int>) {
        self.views = views
        self.currentIndex = currentIndex
        self.currentPage = currentPage
        self.pointsPage = pointsPage
        self.forceMoveToNextPoint = forceMoveToNextPoint
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
        PagesViewerCoordinator(forceMoveToNextPoint, views, currentIndex, currentPage, pointsPage)
    }
    
    internal func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        let last: Int,
            count: Int,
            direction: UIPageViewController.NavigationDirection
        var index: Int
        
        count = context.coordinator.controllers.count
        last = context.coordinator.lastIndex
        
        
        if let currentIndex = self.currentIndex?.wrappedValue {
            index = currentIndex
        } else if let currentPage = self.currentPage?.wrappedValue {
            index = currentPage - 1
        } else {
            return
        }
        
        if index >= count && last < count  {
            print("???????????? ?????? ?????????? ???????????????? ?????????? ???? ???????????????????? ??????????????")
            DispatchQueue.main.async {
                self.currentPage?.wrappedValue = 1
                self.currentIndex?.wrappedValue = 0
            }
            index = 0
        }
        
        direction = index > last ? .forward : .reverse
        if last == index { return }
        
        DispatchQueue.main.async {
            context.coordinator.lastIndex = index
            pageViewController.setViewControllers(
                [context.coordinator.controllers[index]], direction: direction, animated: true)
            
            if context.coordinator.pointsPage.wrappedValue != index{
                context.coordinator.pointsPage.wrappedValue = index
            }
        }

    }

}
