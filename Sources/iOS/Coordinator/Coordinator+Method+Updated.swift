/*
 
 Project: PageViewer
 File: Coordinator+Method+Transition.swift
 Created by: Egor Boyko
 Date: 28.08.2023
 
 Status: #Complete | #Not decorated
 
 */

import UIKit

extension Coordinator {
    func updated(
        _ pageViewController: UIPageViewController,
        index: Int?,
        coordinator: Coordinator<Content>){
            guard let index, !self.animated else {
                return
            }
            if self.locked {
                self.indexQuene.append(index)
                return
            }
            self.transition(pageViewController, index: index, coordinator: coordinator)
        }
}
