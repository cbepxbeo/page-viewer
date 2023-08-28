/*
 
 Project: PageViewer
 File: PageViewRepresentable+Method+UpdateCoordinator.swift
 Created by: Egor Boyko
 Date: 28.08.2023
 
 Status: #Complete | #Not decorated
 
 */

import SwiftUI

extension PageViewRepresentable {
    func updateCoordinator(_ pageViewController: UIPageViewController, _ context: Context){
        let coordinator = context.coordinator
        
        if coordinator.dataSource.views.count != self.views.count {
            coordinator.dataSource.setViews(self.views)
            self.debugMessage(#function, "Set root View")
            if let root = context.coordinator.dataSource.root {
                pageViewController.setViewControllers(
                    [root], direction: .forward, animated: true)
            }
        }
        
        if coordinator.index == nil, let index {
            self.debugMessage(#function, "New index value")
            coordinator.index = index
            coordinator.dataSource.lastIndex = index.wrappedValue
            DispatchQueue.main.async {
                if index.wrappedValue > coordinator.dataSource.total - 1 {
                    self.warningMessage(
                        #function,
                        "Binding value is out of bounds.",
                        "Max index: \(coordinator.dataSource.total - 1)",
                        "Input: \(index.wrappedValue)"
                    )
                    index.wrappedValue = coordinator.dataSource.total - 1
                } else if index.wrappedValue < 0 {
                    self.warningMessage(
                        #function,
                        "Binding value cannot be negative.",
                        "Input: \(index.wrappedValue)"
                    )
                    index.wrappedValue = 0
                }
            }
        }
   
        
        if coordinator.externalDelegate !== self.delegate {
            self.debugMessage(#function, "New Delegate")
            coordinator.externalDelegate = self.delegate
        }
        
        if coordinator.dataSource.looped != self.looped {
            self.debugMessage(#function, "New looped value: \(self.looped)")
            coordinator.dataSource.looped = self.looped
            coordinator.pageViewController?.dataSource = nil
            coordinator.pageViewController?.dataSource = coordinator.dataSource
        }
        
        if coordinator.externalController !== self.controller {
            self.debugMessage(#function, "New Controller")
            coordinator.externalController = self.controller
            self.controller?.pageViewCoordinator = .init(coordinator: coordinator)
        }
        
        if coordinator.scrollEnabled != self.scrollEnabled {
            self.debugMessage(#function, "New scrollEnabled value: \(self.scrollEnabled)")
            coordinator.scrollView?.isScrollEnabled = self.scrollEnabled
            coordinator.scrollEnabled = self.scrollEnabled
        }
    }
}
