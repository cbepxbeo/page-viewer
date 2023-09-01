/*
 
 Project: PageViewer
 File: Coordinator+Method+Transition.swift
 Created by: Egor Boyko
 Date: 28.08.2023
 
 Status: #Completed | #Not required
 
 */

import UIKit

extension Coordinator {
    func transition(
        _ pageViewController: UIPageViewController,
        index: Int,
        coordinator: Coordinator<Content>){
            self.lock()
            let lastIndex = coordinator.dataSource.lastIndex
            
            let checkedIndex = checkIndex(
                total: coordinator.dataSource.total,
                index: index
            ).nearest
            
            if lastIndex == checkedIndex {
                self.unlock()
                return
            }
            
            let navigationDirection: UIPageViewController.NavigationDirection =
            checkedIndex > lastIndex ? .forward : .reverse
            
            coordinator.dataSource.lastIndex = checkedIndex
            pageViewController.setViewControllers(
                [coordinator.dataSource.views[checkedIndex]()],
                direction: navigationDirection,
                animated: true
            ){ value in
                self.externalDelegate?.indexAfterAnimation(checkedIndex)
                self.externalDelegate?.didFinishAnimating(true)
            }
            
            /*
             We limit unnecessary clicks and remove the block after a delay.
             The first method(Updated), which takes an index, buffers all values
             until the lock is released.
             */
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){ [weak self] in
                self?.unlock()
                if let lastLocked = self?.indexQuene.last {
                    self?.indexQuene = []
                    self?.transition(pageViewController, index: lastLocked, coordinator: coordinator)
                }
            }
        }
}
