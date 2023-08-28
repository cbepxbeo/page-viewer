/*
 
 Project: PageViewer
 File: PageViewController+Implementation.swift
 Created by: Egor Boyko
 Date: 26.08.2023
 
 Status: #Complete | #Not decorated
 
 */

extension PageViewController {
    public func go(to option: CoordinatorOption){
        self.pageViewCoordinator?.coordinator?.goTo(option)
    }
    public var scrollEnabled: Bool {
        get {
            self.pageViewCoordinator?.coordinator?.scrollView?.isScrollEnabled ?? false
        }
        set {
            self.pageViewCoordinator?.coordinator?.scrollEnabled = newValue
            self.pageViewCoordinator?.coordinator?.scrollView?.isScrollEnabled = newValue
        }
    }
    
}
