/*
 
 Project: PageViewer
 File: Coordinator+Method+GoTo.swift
 Created by: Egor Boyko
 Date: 28.08.2023
 
 Status: #Complete | #Not decorated
 
 */

import UIKit

extension Coordinator {
    func goTo(_ option: CoordinatorOption) {
        let methodName = #function
        func worker(){
            guard let pageViewController else {
                self.warningMessage(methodName, "PageViewController indefined")
                return
            }
            let index: Int?
            switch option {
            case .first:
                index = 0
            case .last:
                if self.dataSource.lastIndex == self.dataSource.total - 1 {
                    index = nil
                } else {
                    index = self.dataSource.total - 1
                }
            case .next:
                if self.dataSource.lastIndex == self.dataSource.total - 1 {
                    if self.dataSource.looped {
                        index = 0
                    } else {
                        index = nil
                    }
                } else {
                    index = self.dataSource.lastIndex + 1
                }
            case .previous:
                if self.dataSource.lastIndex == 0 {
                    if self.dataSource.looped {
                        index = self.dataSource.total - 1
                    } else {
                        index = nil
                    }
                } else {
                    index = self.dataSource.lastIndex + 1
                }
            }
            guard let index else {
                self.debugMessage(methodName, "No action required. Option: \(option)")
               
                return
            }
            self.transition(pageViewController, index: index, coordinator: self)
        }
        if Thread.isMainThread {
            worker()
        } else {
            self.warningMessage(methodName, "not called from the main thread")
            DispatchQueue.main.async {
                worker()
            }
        }
    }
}
