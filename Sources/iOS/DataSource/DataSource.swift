/*
 
 Project: PageViewer
 File: DataSource.swift
 Created by: Egor Boyko
 Date: 24.08.2023
 
 Status: #Complete | #Not decorated
 
 */

import SwiftUI

final class DataSource<Content: View>: NSObject, UIPageViewControllerDataSource {
    func setViews(_ views: [Content]){
        var temp: [Hosting<Content>] = []
        for (index, element) in views.enumerated() {
            temp.append(Hosting(index: index, rootView: element))
        }
        self.views = temp
        self.total = temp.count
    }
    
    var looped: Bool = false
    var total: Int = 0
    var lastIndex: Int = 0
    var views: [Hosting<Content>] = []
    var root: Hosting<Content>? {
        if total == 0 { return nil }
        
        if lastIndex <= 0 {
            return self.views.first
        }
        
        if lastIndex >= total {
            return self.views.last
        }

        return self.views[lastIndex]
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController) -> UIViewController? {
            self.beforeController(pageViewController, viewController)
        }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController) -> UIViewController? {
            self.afterController(pageViewController, viewController)
        }
    
    weak var coordinator: Coordinator<Content>?
    
}
