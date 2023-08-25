/*
 
 Project: PageViewer
 File: Delegate+Method+DidFinishAnimating.swift
 Created by: Egor Boyko
 Date: 24.08.2023
 
 Status: #Complete | #Not decorated
 
 */

import SwiftUI

extension Delegate {
    @inlinable
    func didFinishAnimating(
        _ pageViewController: UIPageViewController,
        _ finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool){
            guard
                let hosting = pageViewController.viewControllers?.first as? Hosting<Content>,
                let previousHosting = previousViewControllers.first as? Hosting<Content>
            else {
                return
            }
            
            if completed {
                DispatchQueue.main.async { [weak self] in
                    if self?.coordinator?.index?.wrappedValue != hosting.index {
                        self?.coordinator?.index?.wrappedValue = hosting.index
                    }
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.coordinator?.dataSource.lastIndex = previousHosting.index
                    self?.coordinator?.index?.wrappedValue = previousHosting.index
                }
            }
        }
}
