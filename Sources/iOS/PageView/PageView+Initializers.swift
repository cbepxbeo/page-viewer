/*
 
 Project: PageViewer
 File: PageView+Initializers.swift
 Created by: Egor Boyko
 Date: 25.08.2023
 
 Status: #Complete | #Decorated
 
 */

import SwiftUI

extension PageView {
    ///Generating a Vew with Binding from a collection using an index and an element.
    ///
    ///     @State var index: Int = 0
    ///     let collection: [Int] = [1,2,3,4,5]
    ///
    ///     var body: some View {
    ///         PageView(collection, index: $index) { index, element in
    ///             VStack {
    ///                 Text("Element: \(element)")
    ///                 Text("Index: \(index)")
    ///             }
    ///         }
    ///     }
    ///
    ///You can take full advantage of the ViewBuilder and create unique views for each element
    ///
    ///     @State var index: Int = 0
    ///     let collection: [Int] = [1,2,3,4,5]
    ///
    ///     var body: some View {
    ///         PageView(collection, index: $index) { index, element in
    ///             if index == 0 {
    ///                 ZStack{
    ///                     Color.red
    ///                     Text("Zero")
    ///                 }
    ///             } else {
    ///                 Text("Other index. Element: \(element)")
    ///             }
    ///         }
    ///     }
    ///
    ///- Parameter collection: The collection based on which the generation will occur.
    ///- Parameter index: Binding to manage and get the actual index of the currently displayed view.
    ///- Parameter content: Closure providing index and collection element to generate view.
    ///- Warning: Don't use Binding to change PageView states. This will lead to undefined behavior.
    ///the index will get a new value at the moment when the user has just started to scroll, but has not finished yet.
    ///For example, you may want to disable gestures at a certain index. By using anchor values you will disable
    ///gestures before the view has actually completed the transition. Instead, use the values from the delegate.
    ///- Note: If you don't need an index to generate views, use a different initializer.
    public init(
        _ collection: Collection,
        index: Binding<Int>,
        @ViewBuilder content: @escaping (
            _ index: Collection.Index,
            _ element: Collection.Element) -> Content){
                let views = Array(zip(collection.indices, collection)).map { (index, element) in
                    { content(index, element) }
                }
                self.init(
                    index: index,
                    views: views
                )
            }
    ///Generating a Vew without Binding from a collection using an index and an element.
    ///
    ///     let collection: [Int] = [1,2,3,4,5]
    ///
    ///     var body: some View {
    ///         PageView(collection) { index, element in
    ///             VStack {
    ///                 Text("Element: \(element)")
    ///                 Text("Index: \(index)")
    ///             }
    ///         }
    ///     }
    ///
    ///You can take full advantage of the ViewBuilder and create unique views for each element
    ///
    ///     let collection: [Int] = [1,2,3,4,5]
    ///
    ///     var body: some View {
    ///         PageView(collection) { index, element in
    ///             if index == 0 {
    ///                 ZStack{
    ///                     Color.red
    ///                     Text("Zero")
    ///                 }
    ///             } else {
    ///                 Text("Other index. Element: \(element)")
    ///             }
    ///         }
    ///     }
    ///
    ///- Parameter collection: The collection based on which the generation will occur.
    ///- Parameter content: Closure providing index and collection element to generate view.
    ///- Note: To manage transitions, use an external controller and the appropriate modifier to set it.
    ///If you don't need an index to generate views, use a different initializer.
    public init(
        _ collection: Collection,
        @ViewBuilder content: @escaping (
            _ index: Collection.Index,
            _ element: Collection.Element) -> Content){
                let views = Array(zip(collection.indices, collection)).map { (index, element) in
                    { content(index, element) }
                }
                self.init(
                    index: nil,
                    views: views
                )
            }
    ///Generating a Vew with Binding from a collection using an element.
    ///
    ///     @State var index: Int = 0
    ///     let collection: [Int] = [1,2,3,4,5]
    ///
    ///     var body: some View {
    ///         PageView(collection, index: $index) { element in
    ///             VStack {
    ///                 Text("Element: \(element)")
    ///             }
    ///         }
    ///     }
    ///
    ///You can take full advantage of the ViewBuilder and create unique views for each element
    ///
    ///     @State var index: Int = 0
    ///     let collection: [Int] = [1,2,3,4,5]
    ///
    ///     var body: some View {
    ///         PageView(collection, index: $index) { element in
    ///             if element == 1 {
    ///                 ZStack{
    ///                     Color.red
    ///                     Text("First")
    ///                 }
    ///             } else {
    ///                 Text("Other element. Element: \(element)")
    ///             }
    ///         }
    ///     }
    ///
    ///- Parameter collection: The collection based on which the generation will occur.
    ///- Parameter index: Binding to manage and get the actual index of the currently displayed view.
    ///- Parameter content: Closure providing index and collection element to generate view.
    ///- Warning: Don't use Binding to change PageView states. This will lead to undefined behavior.
    ///the index will get a new value at the moment when the user has just started to scroll, but has not finished yet.
    ///For example, you may want to disable gestures at a certain index. By using anchor values you will disable
    ///gestures before the view has actually completed the transition. Instead, use the values from the delegate.
    ///- Note: If you need an index to generate a view, use a different initializer.
    public init(
        _ collection: Collection,
        index: Binding<Int>,
        @ViewBuilder content: @escaping (_ element: Collection.Element) -> Content){
            let views = Array(collection).map { item in { content(item) } }
            self.init(
                index: index,
                views: views
            )
        }
    ///Generating a Vew without Binding from a collection using an element.
    ///
    ///     let collection: [Int] = [1,2,3,4,5]
    ///
    ///     var body: some View {
    ///         PageView(collection) { element in
    ///             VStack {
    ///                 Text("Element: \(element)")
    ///             }
    ///         }
    ///     }
    ///
    ///You can take full advantage of the ViewBuilder and create unique views for each element
    ///
    ///     let collection: [Int] = [1,2,3,4,5]
    ///
    ///     var body: some View {
    ///         PageView(collection) { element in
    ///             if element == 1 {
    ///                 ZStack{
    ///                     Color.red
    ///                     Text("First")
    ///                 }
    ///             } else {
    ///                 Text("Other element. Element: \(element)")
    ///             }
    ///         }
    ///     }
    ///
    ///- Parameter collection: The collection based on which the generation will occur.
    ///- Parameter content: Closure providing index and collection element to generate view.
    ///- Note: To manage transitions, use an external controller and the appropriate modifier to set it.
    ///If you need an index to generate a view, use a different initializer.
    public init(
        _ collection: Collection,
        @ViewBuilder content: @escaping (_ element: Collection.Element) -> Content){
            let views = Array(collection).map { item in { content(item) } }
            self.init(
                index: nil,
                views: views
            )
        }
}

extension PageView where Collection == [Never] {
    ///Create from ready-made representations in an array with Binding
    ///
    ///     @State var index: Int = 0
    ///
    ///     let array: [Color] = [
    ///         .red,
    ///         .blue,
    ///         .green
    ///     ]
    ///
    ///     var body: some View {
    ///         PageView(views: array, index: $index)
    ///     }
    ///
    ///- Parameter views: Array of views.
    ///- Parameter index: Binding to manage and get the actual index of the currently displayed view.
    ///- Warning: Don't use Binding to change PageView states. This will lead to undefined behavior.
    ///the index will get a new value at the moment when the user has just started to scroll, but has not finished yet.
    ///For example, you may want to disable gestures at a certain index. By using anchor values you will disable
    ///gestures before the view has actually completed the transition. Instead, use the values from the delegate.
    ///- Note: If you need to generate views use a different initializer.
    public init(views: [Content], index: Binding<Int>){
        self.init(
            index: index,
            views: views.map{item in { item }}
        )
    }
    ///Create from ready-made representations in an array without Binding
    ///
    ///     let array: [Color] = [
    ///         .red,
    ///         .blue,
    ///         .green
    ///     ]
    ///
    ///     var body: some View {
    ///         PageView(views: array)
    ///     }
    ///
    ///- Parameter views: Array of views.
    ///- Note: To manage transitions, use an external controller and the appropriate modifier to set it.
    ///If you need to generate views use a different initializer.
    public init(views: [Content]){
        self.init(
            index: nil,
            views: views.map{item in { item }}
        )
    }
}
