/*
 
 Project: PageViewer
 File: PageView.swift
 Created by: Egor Boyko
 Date: 24.08.2023
 
 Status: #Complete | #Decorated
 
 */

import SwiftUI

///A View that paginates other views with the possibility of looping them and using gestures.
///
///If you are using full screen output, then you need to specify it for the required views.
///
///     let collection: [Int] = [1,2,3,4,5]
///
///     var body: some View {
///         PageView(collection) { index, element in
///             if index == 0 {
///                 ZStack {
///                     Color.red
///                     Text("Element: \(element)")
///                 }
///                 .ignoresSafeArea() //Will ignore
///             } else {
///                 ZStack {
///                     Color.green
///                     Text("Element: \(element)")
///                 } //Will not
///             }
///         }
///     }
///
///Use the binding for its intended purpose, i.e. pass a new value, display external controls.
///Don't use it to monitor the state of PydgeView itself.
///Using a Binding to control state will lead to incorrect behavior.
///
///Use a delegate to access the actual index.
///
///     final class ExampleViewModel: ObservableObject, PageViewDelegate {
///         //Required by a delegate
///         func willTransition(_ pendingIndex: Int) {
///             //Your code
///         }
///         //Required by a delegate
///         func didFinishAnimating(_ completed: Bool) {
///             //Your code
///         }
///
///         //Property to store index and view notifications
///         @Published
///         var currentIndex: Int = 0
///
///         //Delegate method that receives the index after the transition animation.
///         //Runs on the main thread
///         func indexAfterAnimation(_ index: Int) {
///             self.currentIndex = index
///         }
///
///     }
///     struct ExampleView: View {
///         @StateObject var viewModel = ExampleViewModel()
///         @State var index: Int = 0 //Do not use for state control in modifiers
///         let collection: [Int] = [1,2,3,4,5]
///
///         var body: some View {
///             PageView(collection, index: $index) { index, element in
///                 ZStack {
///                     Color.red
///                     if index != 1 {
///                         Text("Element: \(element)")
///                     } else {
///                         //Appears in a view with scroll disabled and allows
///                         //you to navigate to the next view
///                         Button("Go to view at index 2"){
///                             self.index = 2 //You can assign for switching
///                         }
///                     }
///                 }
///             }
///             .delegate(self.viewModel) //Installing a delegate
///             //Disable scroll gestures for view at index 1
///             .scrollEnabled(self.viewModel.currentIndex != 1) //Correct
///             //.scrollEnabled(self.index != 1) Wrong
///         }
///     }
///
///Use the controller for programmatic control
///
///     final class ExampleViewModel: ObservableObject, PageViewController {
///         //Required by a controller
///         var pageViewCoordinator: CoordinatorStorage?
///     }
///     struct ExampleView: View {
///         @StateObject var viewModel = ExampleViewModel()
///         let collection: [Int] = [1,2,3,4,5]
///
///         var body: some View {
///             VStack{
///                 PageView(collection, index: $index) {  element in
///                     Text("Element: \(element)")
///                 }
///                 .controller(self.viewModel)
///                 Button("Go to next"){
///                     self.viewModel.go(to: .next)
///                 }
///                 //The go method is provided by default
///             }
///         }
///     }
///
///Use your own implementation of indicators with styles
///
///     struct ExampleIndicatorsStyle: IndicatorStyle {
///         func makeIndicator(selected: Bool, index: Int) -> some View {
///             Circle()
///                 .fill(selected ? .red : .green)
///                 .frame(width: 30, height: 30)
///         }
///         func makeConfiguredPageView(
///             content: () -> Content,
///             indicators: () -> Indicators) -> some View {
///                 VStack{
///                     content()
///                     HStack{
///                         indicators()
///                     }
///                     .padding(.top, 50)
///                 }
///         }
///     }
///
///     struct ExampleView: View {
///         let collection: [Int] = [1,2,3,4,5]
///         var body: some View {
///             PageView(collection) {  element in
///                 Text("Element: \(element)")
///             }
///             .indicators(ExampleIndicatorsStyle())
///         }
///     }
///
///
public struct PageView<Collection: RandomAccessCollection, Content: View, Key: PageViewKey>: View {
    init(
        index: Binding<Int>?,
        key: Binding<Key>?,
        indicesStorage: [Key: Int],
        keyStorage: [Int: Key],
        views: [() ->Content]) {
            self.delegate = nil
            self.controller = nil
            self.views = views
            self.indicesStorage = indicesStorage
            self.keyStorage = keyStorage
            self.externalIndex = index
            self.looped = false
            self.scrollEnabled = true
            self.key = key
        }
    
    weak var delegate: PageViewDelegate? = nil
    weak var controller: PageViewController? = nil
    var looped: Bool = false
    var scrollEnabled: Bool = true
    var externalIndex: Binding<Int>?
    let views: [() -> Content]
    
    @State private var localIndex: Int = 0
    private let indicesStorage: [Key: Int]
    private let keyStorage: [Int: Key]
    private let key: Binding<Key>?
   
    private var index: Binding<Int> {
        if let externalIndex {
            return externalIndex
        }
        if let key {
            return .init(get: { indicesStorage[key.wrappedValue] ?? 0 }, set: {
                if let newKey = keyStorage[$0] {
                    key.wrappedValue = newKey
                }
            })
        }
        return .init(get: { self.localIndex }, set: {self.localIndex = $0})
    }
        
    public var body: some View {
        PageViewRepresentable(
            views: self.views,
            index: self.index,
            scrollEnabled: self.scrollEnabled,
            looped: self.looped,
            delegate: self.delegate,
            controller: self.controller
        )
        .ignoresSafeArea()
    }
}
