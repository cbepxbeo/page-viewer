//
// Project: PageViewer
// File: PagesViewerCoordinator.swift
// Created by: Egor Boyko
// Date: 22.10.2022
//
// Status: #In progress | #Not decorated
//
import SwiftUI

final internal class PagesViewerCoordinator<T>: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate where T:View {
    
    typealias Hosting = PageViewerHostingController
    
    internal init(_ forceMoveToNextPoint: Bool, _ views: [T], _ currentIndex: Binding<Int>?, _ currentPage: Binding<Int>?, _ pointsPage: Binding<Int>) {
        var temp: [Hosting<AnyView>] = []
        for (index, element) in views.enumerated() {
            temp.append(Hosting(index: index, rootView: AnyView(element.ignoresSafeArea())))
        }
        self.pointsPage = pointsPage
        self.forceMoveToNextPoint = forceMoveToNextPoint
        self.controllers = temp
        self.currentIndex = currentIndex
        self.currentPage = currentPage
        self.root = controllers.first
        self.lastIndex = currentIndex?.wrappedValue ?? ((currentPage?.wrappedValue ?? 1) - 1)
    }
    
    internal let controllers: [Hosting<AnyView>]
    internal let root: Hosting<AnyView>?
    internal let pointsPage: Binding<Int>
    internal var lastIndex: Int
    
    private let currentIndex: Binding<Int>?
    private let currentPage: Binding<Int>?
    private let forceMoveToNextPoint: Bool
    
    internal func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard
                let hosting = viewController as? Hosting<AnyView>
            else {
                return nil
            }
            let index = hosting.index == 0 ? controllers.count - 1 : hosting.index - 1
            self.lastIndex = index
            return controllers[index]
        }
    
    internal func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard
                let hosting = viewController as? Hosting<AnyView>
            else {
                return nil
            }
            let index = hosting.index + 1 == controllers.count ? 0 : hosting.index + 1
            self.lastIndex = index
            return controllers[index]
        }
    
    internal func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool) {
            guard
                let hosting = pageViewController.viewControllers?.first as? Hosting<AnyView>
            else {
                return
            }
            
            DispatchQueue.main.async {
                self.currentIndex?.wrappedValue = hosting.index
                self.currentPage?.wrappedValue = hosting.index + 1
                if hosting.index != self.pointsPage.wrappedValue {
                    self.pointsPage.wrappedValue = hosting.index
                }
            }
        }
    
    internal func pageViewController(
        _ pageViewController: UIPageViewController,
        willTransitionTo pendingViewControllers: [UIViewController]){
            guard
                let hosting = pendingViewControllers.first as? Hosting<AnyView>,
                forceMoveToNextPoint
            else {
                return
            }
            DispatchQueue.main.async {
                if hosting.index != self.pointsPage.wrappedValue {
                    self.pointsPage.wrappedValue = hosting.index
                }
            }
        }
}
