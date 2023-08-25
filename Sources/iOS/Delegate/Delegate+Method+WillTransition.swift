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
            guard
                let afterHosting = pendingViewControllers.first as? Hosting<Content>
            else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                if afterHosting.index != self?.coordinator?.index?.wrappedValue {
                    self?.coordinator?.index?.wrappedValue = afterHosting.index
                }
            }
        }
}
