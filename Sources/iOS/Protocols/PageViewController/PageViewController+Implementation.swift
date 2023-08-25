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
}
