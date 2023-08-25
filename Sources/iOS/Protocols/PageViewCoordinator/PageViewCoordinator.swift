/*
 
 Project: PageViewer
 File: PageViewCoordinator.swift
 Created by: Egor Boyko
 Date: 24.08.2023
 
 Status: #Complete | #Not decorated
 
 */

protocol PageViewCoordinator: AnyObject {
    func goTo(_ option: CoordinatorOption)
}
