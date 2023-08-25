/*
 
 Project: PageViewer
 File: PageView+Initializers.swift
 Created by: Egor Boyko
 Date: 25.08.2023
 
 Status: #Complete | #Not decorated
 
 */

import SwiftUI

extension PageView {
    public init(
        _ collection: Collection,
        index: Binding<Int>? = nil,
        @ViewBuilder content: @escaping (Collection.Index, Collection.Element) -> Content){
            let views = Array(zip(collection.indices, collection)).map { (index, element) in
                content(index, element)
            }
            self.init(index: index, looped: false, delegate: nil, controller: nil, views: views)
        }
}
