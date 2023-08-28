/*
 
 Project: PageViewer
 File: Coordinator+Method+Transition.swift
 Created by: Egor Boyko
 Date: 28.08.2023
 
 Status: #Complete | #Not decorated
 
 */

import UIKit

extension Coordinator {
    @inlinable
    func lock(){
        self.locked = true
        self.scrollView?.isScrollEnabled = false
    }
    
    @inlinable
    func unlock(){
        self.locked = false
        if self.scrollEnabled {
            self.scrollView?.isScrollEnabled = true
        }
    }
    
    /*
     Method for checking the index for validity.
     Returns the nearest valid index or optional that will be nil
     when input index out of range.
     Used when updating a Bindle and in a programmatic transition method (goTo).
     */
    @inlinable
    func checkIndex(
        total: Int,
        index input: Int,
        methodName: String = #function) -> (output: Int?, nearest: Int) {
        let output: (Int?, Int)
        if (total - 1) < input {
            self.warningMessage(
                methodName,
                "Index is out of bounds.",
                "Max index: \(self.dataSource.total - 1)",
                "Input: \(input)"
            )
            output = (nil, total - 1)
        } else if 0 > input {
            self.warningMessage(
                methodName,
                "Index cannot be negative.",
                "Input: \(input)"
            )
            output = (nil, 0)
        } else {
            output = (input, input)
        }
        return output
    }
}
