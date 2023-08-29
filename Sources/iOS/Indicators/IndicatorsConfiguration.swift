/*
 
 Project: PageViewer
 File: IndicatorsConfiguration.swift
 Created by: Egor Boyko
 Date: 29.08.2023
 
 Status: #Complete | #Not decorated
 
 */

import SwiftUI

public struct IndicatorsConfiguration<Style: IndicatorStyle>: View {
    let range: Range<Int>
    let index: Int?
    let style: () -> Style
    public var body: some View {
        ForEach(range, id: \.self){ index in
            IndicatorStorage(
                index: index,
                selected: index == self.index,
                style: style
            )
        }
    }
}
