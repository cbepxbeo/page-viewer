/*
 
 Project: PageViewer
 File: IndicatorStorage.swift
 Created by: Egor Boyko
 Date: 29.08.2023
 
 Status: #Complete | #Not decorated
 
 */

import SwiftUI

public struct IndicatorStorage<Style: IndicatorStyle>: View {
    let index: Int
    let selected: Bool
    let style: () -> Style
    public var body: some View {
        style().makeIndicator(selected: selected, index: index)
    }
}
