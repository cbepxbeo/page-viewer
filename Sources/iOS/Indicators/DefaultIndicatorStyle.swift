/*
 
 Project: PageViewer
 File: DefaultIndicatorStyle.swift
 Created by: Egor Boyko
 Date: 29.08.2023
 
 Status: #Complete | #Not decorated
 
 */

import SwiftUI

public struct DefaultIndicatorStyle: IndicatorStyle {
    public init(){}
    public func makeIndicator(selected: Bool, index: Int) -> some View {
        ZStack{
            Color.red.opacity(selected ? 1: 0.5)
                .animation(.spring(), value: selected)
        }
        .frame(width: 50, height: 50)
    }
}
