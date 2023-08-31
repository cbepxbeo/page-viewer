/*
 
 Project: PageViewer
 File: PageViewController+Implementation.swift
 Created by: Egor Boyko
 Date: 26.08.2023
 
 Status: #Complete | #Decorated
 
 */

extension PageViewController {
    ///Transition to view
    /// - Parameter option: Specifies which view to transition to
    public func go(to option: CoordinatorOption){
        self.pageViewCoordinator?.coordinator?.goTo(option)
    }
}
