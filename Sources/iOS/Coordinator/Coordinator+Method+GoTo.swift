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
            case .index(let input):
                if input > self.dataSource.total - 1 {
                    self.warningMessage(
                        methodName,
                        "Index is out of bounds.",
                        "Max index: \(self.dataSource.total - 1)",
                        "Input: \(input)"
                    )
                    index = nil
                } else if input < 0 {
                    self.warningMessage(
                        methodName,
                        "Index cannot be negative.",
                        "Input: \(input)"
                    )
                    index = nil
                } else {
                    index = input
                }
            }
            guard let index else {
                self.debugMessage(methodName, "No action required. Option: \(option)")
                return
            }
            self.index?.wrappedValue = index
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
