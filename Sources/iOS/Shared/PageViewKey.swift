/*
 
 Project: PageViewer
 File: PageViewKey.swift
 Created by: Egor Boyko
 Date: 02.09.2023
 
 Status: #Completed | #Not decoreted
 
 */

import Foundation

public protocol PageViewKey: CaseIterable, Hashable {}

public extension PageViewKey {
    static func from(index input: Int) -> Self {
        var index: Int = 0
        var result: Self? = nil
        Self.allCases.forEach {
            if input == index {
                result = $0
            }
            index += 1
            if index == Self.allCases.count {
                result = $0
            }
        }
        return result!
    }
}
