/*
 
 Project: PageViewer
 File: IndicatorStyle.swift
 Created by: Egor Boyko
 Date: 29.08.2023
 
 Status: #Complete | #Not decorated
 
 */

import SwiftUI

public protocol IndicatorStyle {
    associatedtype Indicator: View
    func makeIndicator(selected: Bool, index: Int) -> Indicator
}
