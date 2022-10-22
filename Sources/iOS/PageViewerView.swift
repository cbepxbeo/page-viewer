//
// Project: PageViewer
// File: PageViewerView.swift
// Created by: Egor Boyko
// Date: 21.10.2022
//
// Status: #In progress | #Not decorated
//

import SwiftUI


struct PageViewerComponent<A: RandomAccessCollection, C: View>: View where C : Identifiable {
    public init(_ array: A, @ViewBuilder content: @escaping (A.Index, A.Element) -> C){
        self.views = Array(zip(array.indices, array)).map { (index, element) in
            content(index, element)
        }
    }
    private let views: [C]
    
    var body: some View {
        PagesViewer(views: views)
    }
}

extension PageViewerComponent where A == [Any] {
    init(views: [C]){
        self.views = views
    }
}


fileprivate struct PagesViewer<T>: UIViewControllerRepresentable where T:View, T:Identifiable {
    
    let views: [T]
    
    internal func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator
        pageViewController.setViewControllers(
            [context.coordinator.root], direction: .forward, animated: true)
        return pageViewController
    }
    
    func makeCoordinator() -> PagesViewerCoordinator<T> {
        PagesViewerCoordinator(views)
    }
    
    
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        //изменения в SwiftUI
    }
    
}


fileprivate final class PagesViewerCoordinator<T>: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate where T:View, T:Identifiable {
    
    let views: [T]
    let root: UIHostingController<T>
    var indexStorage: [T.ID: Int]
    
    init(_ views: [T]) {
        self.views = views
        self.root = UIHostingController(rootView: views.first!)
        self.indexStorage = PagesViewerCoordinator<T>.getIndexStorage(views)
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard
                let hosting = viewController as? UIHostingController<T>
            else {
                return nil
            }
            
            let index: Int
            
            if indexStorage[hosting.rootView.id] != nil {
               index = indexStorage[hosting.rootView.id]!
            } else if let temp = views.firstIndex(where: { $0.id == hosting.rootView.id }) {
                index = temp
            } else {
                return nil
            }
            
            let bool = index == 0
            return UIHostingController(rootView: bool ? views.last! : views[index - 1])
        }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let hosting = viewController as? UIHostingController<T>
            else { return nil }
            
            let index: Int
            if indexStorage[hosting.rootView.id] != nil {
                index = indexStorage[hosting.rootView.id]!
            } else if let temp = views.firstIndex(where: { $0.id == hosting.rootView.id }) {
                index = temp
            } else { return nil }

            let bool = index + 1 == views.count
            
            return UIHostingController(rootView: bool ? views.first! : views[index + 1])
        }
}


extension PagesViewerCoordinator {
    class func getIndexStorage(_ array: [T]) -> [T.ID: Int] {
        var temp: [T.ID : Int] = [:]
        for (index, element) in array.enumerated() {
            temp[element.id] = index
        }
        return temp
    }
}

