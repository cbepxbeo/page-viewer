/*
 
 Project: PageViewer
 File: Delegate.swift
 Created by: Egor Boyko
 Date: 24.08.2023
 
 Status: #Complete | #Not decorated
 
 */

import SwiftUI

final class Delegate<Content: View>: NSObject, UIPageViewControllerDelegate{
    weak var coordinator: Coordinator<Content>? = nil
    func pageViewController(
        _ pageViewController: UIPageViewController,
        willTransitionTo pendingViewControllers: [UIViewController]){
            self.willTransition(pageViewController, pendingViewControllers)
        }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool) {
            self.didFinishAnimating(
                pageViewController,
                finished,
                previousViewControllers: previousViewControllers,
                transitionCompleted: completed
            )
        }
}
