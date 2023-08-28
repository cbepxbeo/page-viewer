/*
 
 Project: PageViewer
 File: PageViewRepresentable+Method+MakeUIViewController.swift
 Created by: Egor Boyko
 Date: 24.08.2023
 
 Status: #Complete | #Not decorated
 
 */

import SwiftUI

extension PageViewRepresentable {
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        pageViewController.dataSource = context.coordinator.dataSource
        pageViewController.delegate = context.coordinator.delegate
        if let root = context.coordinator.dataSource.root {
            pageViewController.setViewControllers(
                [root], direction: .forward, animated: true)
        }
        return pageViewController
    }
}