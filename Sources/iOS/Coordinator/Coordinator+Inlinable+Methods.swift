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
        self.scrollView?.isScrollEnabled = true
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
