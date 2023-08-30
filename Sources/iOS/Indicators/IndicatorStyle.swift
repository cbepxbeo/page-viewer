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
    associatedtype Body: View
    typealias Content = AnyView
    typealias Indicators = AnyView
    func makeIndicator(selected: Bool, index: Int) -> Indicator
    func makeConfiguredPageView(
        content: () -> Content,
        indicators: () -> Indicators) -> Body
}


struct HerZnat {
    typealias Body = Never
}
extension HerZnat: View {
    var body: Never { fatalError() }
}
