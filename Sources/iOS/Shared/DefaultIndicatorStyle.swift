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
            Circle()
                .fill(Color.gray)
            Circle()
                .fill(.white.opacity(selected ? 1 : 0.5))
                .animation(.spring(), value: selected)
                .padding(1)
        }
        .frame(width: 17, height: 17)
    }
    public func makeConfiguredPageView(
        content: () -> Content,
        indicators: () -> Indicators) -> some View {
            VStack{
                content()
                HStack{
                    indicators()
                }
            }
    }
}
