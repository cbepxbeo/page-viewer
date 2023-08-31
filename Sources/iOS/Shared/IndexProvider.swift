/*
 
 Project: PageViewer
 File: PageView+Modifiers.swift
 Created by: Egor Boyko
 Date: 31.08.2023
 
 Status: #Completed | #Not required
 
 */

import SwiftUI

struct IndexProvider<Content: View>: View {
    @State var index: Int = 0
    let content: (Binding<Int>) -> Content
    init(@ViewBuilder content: @escaping (Binding<Int>) -> Content) {
        self.content = content
    }
    var body: some View {
        self.content($index)
    }
}
