/*
 
 Project: PageViewer
 File: DataSource+Method+BeforeController.swift
 Created by: Egor Boyko
 Date: 24.08.2023
 
 Status: #Completed | #Not required
 
 */

import SwiftUI

extension DataSource {
    @inlinable
    func beforeController(
        _ pageViewController: UIPageViewController,
        _ viewController: UIViewController) -> UIViewController? {
            guard
                let hosting = viewController as? Hosting<Content>
            else {
                return nil
            }
            
            if !self.looped && hosting.index == 0 {
                return nil
            }
            
            let index = hosting.index == 0 ? self.total - 1 : hosting.index - 1
            self.lastIndex = index
            return self.views[index]
        }
}
