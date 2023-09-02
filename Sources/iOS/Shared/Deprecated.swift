/*
 
 Project: PageViewer
 File: Deprecated.swift
 Created by: Egor Boyko
 Date: 24.08.2023
 
 Status: #Completed | #Not required
 
 */

import SwiftUI

@available(*,deprecated, renamed: "PageView", message: "Will not be available in the next version")
public typealias PageViewerView = PageView

//MARK: PageView
extension PageView {
    @available(*,deprecated, renamed: "loopedEnabled", message: "Will not be available in the next version")
    public func setCarouselMode(_ isCarousel: Bool) -> PageView {
        var view = self
        view.looped = isCarousel
        return view
    }
    @available(*,deprecated, message: "The method lost relevance and did not perform any actions. Will not be available in the next version")
    public func forceMove(_ forceMoveToNextPoint: Bool) -> PageView {
        self
    }
    @available(*,deprecated, message: "Use modifier indicators. The method lost relevance and did not perform any actions. Will not be available in the next version")
    public func pagePoints(_ showPoints: Bool) -> PageView {
        self
    }
    @available(*,deprecated, message: "Use modifier indicators. The method lost relevance and did not perform any actions. Will not be available in the next version")
    public func pointsStyle(_ style: _PagesViewerPointStyle) -> PageView {
        self
    }
    @available(*,deprecated, message: "Use modifier indicators. The method lost relevance and did not perform any actions. Will not be available in the next version")
    public func pointPosition(_ position: PageViewerPointPosition) -> PageView {
        self
    }
    @available(*,deprecated, message: "Use modifier indicators. The method lost relevance and did not perform any actions. Will not be available in the next version")
    public func pointPadding(_ padding: CGFloat) -> PageView {
        self
    }
    

}

extension PageView where Key == DefaultKey {
    @available(*,deprecated, message: "Will not be available in the next version")
    public init(
        _ array: Collection,
        currentIndex: Binding<Int>,
        @ViewBuilder content: @escaping (Collection.Index, Collection.Element) -> Content){
            self.init(array, index: currentIndex, content: content)
        }
    
    @available(*,deprecated, message: "Will not be available in the next version")
    public init(
        _ array: Collection,
        currentIndex: Binding<Int>,
        @ViewBuilder content: @escaping (Collection.Element) -> Content){
            self.init(array, index: currentIndex, content: content)
        }
    
    @available(*,deprecated, message: "Will not be available in the next version")
    public init(
        _ array: Collection,
        currentPage: Binding<Int>,
        @ViewBuilder content: @escaping (Collection.Index, Collection.Element) -> Content){
            
            let binding: Binding<Int> =
                .init(get: {
                    currentPage.wrappedValue - 1
                }, set: {
                    currentPage.wrappedValue = $0 + 1
                })
            
            self.init(array, index: binding, content: content)
        }
    
    @available(*,deprecated, message: "Will not be available in the next version")
    public init(
        _ array: Collection,
        currentPage: Binding<Int>,
        @ViewBuilder content: @escaping (Collection.Element) -> Content){
            
            let binding: Binding<Int> =
                .init(get: {
                    currentPage.wrappedValue - 1
                }, set: {
                    currentPage.wrappedValue = $0 + 1
                })
            
            self.init(array, index: binding, content: content)
        }
}

extension PageView where Collection == [Never], Key == DefaultKey {
    @available(*,deprecated, message: "Will not be available in the next version")
    public init(views: [Content], currentPage: Binding<Int>){
        let binding: Binding<Int> =
            .init(get: {
                currentPage.wrappedValue - 1
            }, set: {
                currentPage.wrappedValue = $0 + 1
            })
        self.init(
            index: binding,
            views: views.map{item in { item }}
        )
    }
}

//MARK: PagesViewerPointStyle
@available(*,deprecated, message: "Use protocol instead IndicatorStyle. Will not be available in the next version")
public protocol PagesViewerPointStyle: _PagesViewerPointStyle {}

public protocol _PagesViewerPointStyle {
    var borderInactiveColor: Color? { get }
    var bodyInactiveColor: Color? { get }
    var bodyActiveColor: Color? { get }
    var borderActiveColor: Color? { get }
    var size: CGFloat? { get }
    var borderSize: CGFloat? { get }
    var spacing: CGFloat? { get }
    var opacity: CGFloat? { get }
    var padding: CGFloat? { get set }
}
extension _PagesViewerPointStyle {
    var _size: CGFloat {
        self.size ?? 15
    }
    var _opacity: CGFloat {
        self.opacity ?? 1
    }
    var _padding: CGFloat {
        self.padding ?? 10
    }
    var _borderSize: CGFloat {
        guard let bSize = self.borderSize else {
            return 1
        }
        let size = self.size ?? 15
        return size > bSize ? bSize : (size - 1)
    }
    var _spacing: CGFloat {
        self.spacing ?? 5
    }
    
    var _borderInactiveColor: Color {
        let value: CGFloat = 0.85
        return self.borderInactiveColor ?? Color(red: value, green: value, blue: value)
    }
    
    var _borderActiveColor: Color {
        let value: CGFloat = 0.5
        return self.borderActiveColor ?? Color(red: value, green: value, blue: value)
    }
    
    var _bodyInactiveColor: Color {
        let value: CGFloat = 0.95
        return self.bodyInactiveColor ?? Color(red: value, green: value, blue: value)
    }
    
    var _bodyActiveColor: Color {
        let value: CGFloat = 0.6
        return self.bodyActiveColor ?? Color(red: value, green: value, blue: value)
    }
}

public enum PageViewerPointPosition {
    case bottom, top
}
