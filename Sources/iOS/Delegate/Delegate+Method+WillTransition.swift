/*
 
 Project: PageViewer
 File: Delegate+Method+WillTransition.swift
 Created by: Egor Boyko
 Date: 24.08.2023
 
 Status: #Complete | #Not decorated
 
 */

import SwiftUI

extension Delegate {
    @inlinable
    func willTransition(
        _ pageViewController: UIPageViewController,
        _ pendingViewControllers: [UIViewController]){
            self.coordinator?.animated = true
            guard
                let afterHosting = pendingViewControllers.first as? Hosting<Content>
            else {
                return
            }
            
            if afterHosting.index != self.coordinator?.index?.wrappedValue {
                self.coordinator?.index?.wrappedValue = afterHosting.index
            }
            
        }
}
