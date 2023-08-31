/*
 
 Project: PageViewer
 File: DataSource+Method+AfterController.swift
 Created by: Egor Boyko
 Date: 24.08.2023
 
 Status: #Completed | #Not required
 
 */

import SwiftUI

extension DataSource {
    @inlinable
    func afterController(
        _ pageViewController: UIPageViewController,
        _ viewController: UIViewController) -> UIViewController? {
            guard
                let hosting = viewController as? Hosting<Content>
            else {
                return nil
            }
            
            if !self.looped && hosting.index + 1 == self.total {
                return nil
            }
            
            let index = hosting.index + 1 == self.total ? 0 : hosting.index + 1
            self.lastIndex = index
            return self.views[index]
        }
}
