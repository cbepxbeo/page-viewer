/*
 
 Project: PageViewer
 File: IndicatorStyle.swift
 Created by: Egor Boyko
 Date: 29.08.2023
 
 Status: #Complete | #Decorated
 
 */

import SwiftUI

///Defines the appearance of indicators and their location
public protocol IndicatorStyle {
    ///Indicator view
    associatedtype Indicator: View
    ///The final view of the view with indicators
    associatedtype Body: View
    typealias Content = AnyView
    typealias Indicators = AnyView
    ///Returns a view that defines the appearance of the indicator
    ///- Parameter selected: Is the indicator active
    ///- Parameter index: The index to which the indicator will belong
    func makeIndicator(selected: Bool, index: Int) -> Indicator
    ///Specifies the location of indicators relative to PageView
    ///- Parameter content: Returns a PageView
    ///- Parameter index: Returns ready-made indicators
    func makeConfiguredPageView(
        content: () -> Content,
        indicators: () -> Indicators) -> Body
}
