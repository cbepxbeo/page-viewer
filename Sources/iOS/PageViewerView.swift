//
// Project: PageViewer
// File: PageViewerView.swift
// Created by: Egor Boyko
// Date: 21.10.2022
//
// Status: #In progress | #Not decorated
//

import SwiftUI


struct PageViewerComponent<A: RandomAccessCollection, C: View>: View {
    let currentIndex: Binding<Int>?
    public init(_ array: A, currentIndex: Binding<Int>? = nil, @ViewBuilder content: @escaping (A.Index, A.Element) -> C){
        self.views = Array(zip(array.indices, array)).map { (index, element) in
            content(index, element)
        }
        self.currentIndex = currentIndex
    }
    public init(_ array: A, currentIndex: Binding<Int>? = nil, @ViewBuilder content: @escaping (A.Element) -> C){
        self.views = Array(array).map { content($0) }
        self.currentIndex = currentIndex
    }
    private let views: [C]
    
    var body: some View {
        PagesViewer(views: views, currentIndex: currentIndex)
    }
}

extension PageViewerComponent where A == [Any] {
    init(views: [C], currentIndex: Binding<Int>? = nil){
        self.views = views
        self.currentIndex = currentIndex
    }
}


fileprivate struct PagesViewer<T>: UIViewControllerRepresentable where T : View{
    
    let views: [T]
    let currentIndex: Binding<Int>?
    
    init(views: [T], currentIndex: Binding<Int>? = nil) {
        self.views = views
        self.currentIndex = currentIndex
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
    
    func makeCoordinator() -> PagesViewerCoordinator<T> {
        PagesViewerCoordinator(views, currentIndex: currentIndex)
    }
    
    
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        if context.coordinator.lastIndex == currentIndex?.wrappedValue { return }

        pageViewController.setViewControllers(
            [context.coordinator.controllers[currentIndex?.wrappedValue ?? 0]], direction: .forward, animated: true)
    }
    
}


fileprivate final class CustomUIHostingController<Content>: UIHostingController<Content> where Content: View {
    var index: Int
    init(index: Int, rootView: Content) {
        self.index = index
        super.init(rootView: rootView)
    }
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate final class PagesViewerCoordinator<T>: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate where T:View {
    
    let controllers: [CustomUIHostingController<T>]
    let root: CustomUIHostingController<T>?
    let currentIndex: Binding<Int>?
    var lastIndex: Int
    
    init(_ views: [T], currentIndex: Binding<Int>? = nil) {
        var temp: [CustomUIHostingController<T>] = []
        for (index, element) in views.enumerated() {
            temp.append(CustomUIHostingController(index: index, rootView: element))
        }
        if currentIndex?.wrappedValue ?? 0 > temp.count - 1 {
            currentIndex?.wrappedValue = temp.count - 1
        }
        self.controllers = temp
        self.currentIndex = currentIndex
        self.root = controllers.first
        self.lastIndex = currentIndex?.wrappedValue ?? 0
    }
    
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard
                let hosting = viewController as? CustomUIHostingController<T>
            else {
                return nil
            }
            let index = hosting.index == 0 ? controllers.count - 1 : hosting.index - 1
            self.lastIndex = index
            return controllers[index]
    }
    
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard
                let hosting = viewController as? CustomUIHostingController<T>
            else {
                return nil
            }
            let index = hosting.index == 0 ? 0 : hosting.index + 1
            self.lastIndex = index
            return controllers[index]
        }
    
    
    internal func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool) {
            
            if self.currentIndex == nil { return }
            
            guard
                let hosting = pageViewController.viewControllers?.first as? CustomUIHostingController<T>
            else {
                return
            }
            self.currentIndex?.wrappedValue = hosting.index
        }
}
