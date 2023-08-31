/*
 
 Project: PageViewer
 File: PageView+Modifiers.swift
 Created by: Egor Boyko
 Date: 25.08.2023
 
 Status: #Complete | #Decorated
 
 */

import SwiftUI

extension PageView {
    ///Sets a delegate to receive callbacks from PageView
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
    ///         //Required by a delegate
    ///         func indexAfterAnimation(_ index: Int) {
    ///             //Your code
    ///         }
    ///     }
    ///     struct ExampleView: View {
    ///         @StateObject var viewModel = ExampleViewModel()
    ///         let collection: [Int] = [1,2,3,4,5]
    ///
    ///         var body: some View {
    ///             PageView(collection) {  element in
    ///                 Text("Element: \(element)")
    ///             }
    ///             .delegate(self.viewModel)
    ///         }
    ///     }
    ///
    ///- Parameter value: Delegate
    public func delegate(_ value: PageViewDelegate?) -> Self {
        var view = self
        view.delegate = value
        return view
    }
    ///Sets an external controller for programmatic control
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
    ///- Parameter value: External controller
    ///- Note: PageView does not store references to the external controller, you must ensure its existence yourself.
    ///Once it is released outside of PageView, it will cease to exist.
    ///This will not cause any problems, but you will lose the ability to control PageView.
    public func controller(_ value: PageViewController?) -> Self {
        var view = self
        view.controller = value
        return view
    }
    ///Sets the handling of view flipping gestures. Enabled by default.
    ///- Parameter value: Enable or disable gestures.
    public func scrollEnabled(_ value: Bool) -> Self {
        var view = self
        view.scrollEnabled = value
        return view
    }
    ///Sets the transition mode between extreme views.
    ///Enabling will result in a loop i.e. after the last page you will go to the first, and from the first to the last.
    ///Disabled by default.
    ///- Parameter value: Enable or disable endless transitions.
    public func loopedEnabled(_ value: Bool) -> Self {
        var view = self
        view.looped = value
        return view
    }
    ///Wraps the view and adds indicator pages according to the style.
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
    ///- Parameter style: Defines the appearance of the indicators and their position.
    ///- Parameter maxView: Specifies the maximum number of Views at which indicators will be shown,
    /// if the limit is not required, specify nil.
    ///- Note: Specify this modifier last. it returns some View
    @ViewBuilder
    public func indicators<Style: IndicatorStyle>(
        _ style: Style = DefaultIndicatorStyle(),
        maxView: Int? = 10) -> some View {
            if let maxView, self.views.count > maxView {
                self
            } else {
                if let externalIndex {
                    style.makeConfiguredPageView(content: { AnyView(self) }){
                        AnyView(
                            ForEach(0..<self.views.count, id: \.self){ index in
                                style.makeIndicator(
                                    selected: index == externalIndex.wrappedValue,
                                    index: index
                                )
                            }
                        )
                    }
                } else {
                    IndexProvider { localIndex in
                        var temp = self
                        let _ = { temp.externalIndex = localIndex }()
                        style.makeConfiguredPageView(content: { AnyView(temp) }){
                            AnyView(
                                ForEach(0..<self.views.count, id: \.self){ index in
                                    style.makeIndicator(
                                        selected: index == localIndex.wrappedValue,
                                        index: index
                                    )
                                }
                            )
                        }
                    }
                }
            }
        }
}
