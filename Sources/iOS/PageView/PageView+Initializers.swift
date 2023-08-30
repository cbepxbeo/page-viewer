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
        @ViewBuilder content: @escaping (
            _ index: Collection.Index,
            _ element: Collection.Element) -> Content){
                let views = Array(zip(collection.indices, collection)).map { (index, element) in
                    content(index, element)
                }
                self.init(
                    index: index,
                    views: views
                )
            }
    
    public init(
        _ collection: Collection,
        index: Binding<Int>? = nil,
        @ViewBuilder content: @escaping (_ element: Collection.Element) -> Content){
            let views = Array(collection).map { content($0) }
            self.init(
                index: index,
                views: views
            )
        }
}

extension PageView where Collection == [Never] {
    public init(views: [Content], index: Binding<Int>? = nil){
        self.init(
            index: index,
            views: views
        )
    }
}
