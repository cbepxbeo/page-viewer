/*
 
 Project: PageViewer
 File: UpdatedDataHandler.swift
 Created by: Egor Boyko
 Date: 25.08.2023
 
 Status: #Complete | #Not decorated
 
 */

import SwiftUI

struct UpdatedDataHandler{
    func updated<Content: View>(
        _ pageViewController: UIPageViewController,
        index: Int?,
        coordinator: Coordinator<Content>){
            guard let index else {
                return
            }
            let lastIndex = coordinator.dataSource.lastIndex
            
            let checkedIndex = checkIndex(
                total: coordinator.dataSource.total,
                index: index
            )
            if lastIndex == checkedIndex {
                return
            }

            let navigationDirection: UIPageViewController.NavigationDirection =
            checkedIndex > lastIndex ? .forward : .reverse
            
            DispatchQueue.main.async {
                coordinator.dataSource.lastIndex = checkedIndex
                pageViewController.setViewControllers(
                    [coordinator.dataSource.views[checkedIndex]],
                    direction: navigationDirection,
                    animated: true
                )
            }
        }
    
    
    @inlinable
    func checkIndex(total: Int, index input: Int) -> Int {
        let output: Int
        if (total - 1) < input {
            output = total - 1
        } else if 0 > input {
            output = 0
        } else {
            output = input
        }
        return output
    }
}
