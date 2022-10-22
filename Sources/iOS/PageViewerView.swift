//
// Project: PageViewer
// File: PageViewerView.swift
// Created by: Egor Boyko
// Date: 21.10.2022
//
// Status: #In progress | #Not decorated
//
import SwiftUI

public enum PageViewerPointPosition {
    case bottom, top
}

public struct PageViewerView<A: RandomAccessCollection, C: View>: View {
    //----------public
    public init(_ array: A, currentIndex: Binding<Int>, @ViewBuilder content: @escaping (A.Index, A.Element) -> C){
        self.init(array, currentIndex: currentIndex, currentPage: nil, content: content)
    }
    public init(_ array: A, currentPage: Binding<Int>, @ViewBuilder content: @escaping (A.Index, A.Element) -> C){
        self.init(array, currentIndex: nil, currentPage: currentPage, content: content)
    }
    public init(_ array: A, currentIndex: Binding<Int>, @ViewBuilder content: @escaping (A.Element) -> C){
        self.init(array, currentIndex: currentIndex, currentPage: nil, content: content)
    }
    public init(_ array: A, currentPage: Binding<Int>, @ViewBuilder content: @escaping (A.Element) -> C){
        self.init(array, currentIndex: nil, currentPage: currentPage, content: content)
    }
    public init(_ array: A, @ViewBuilder content: @escaping (A.Element) -> C){
        self.init(array, currentIndex: nil, currentPage: nil, content: content)
    }
    public init(_ array: A, @ViewBuilder content: @escaping (A.Index, A.Element) -> C){
        self.init(array, currentIndex: nil, currentPage: nil, content: content)
    }
    //----------private
    private init(_ array: A, currentIndex: Binding<Int>? = nil, currentPage: Binding<Int>? = nil, @ViewBuilder content: @escaping (A.Index, A.Element) -> C){
        self.views = Array(zip(array.indices, array)).map { (index, element) in
            content(index, element)
        }
        self.currentIndex = currentIndex
        self.currentPage = currentPage
    }
    
    private init(_ array: A, currentIndex: Binding<Int>? = nil, currentPage: Binding<Int>? = nil, @ViewBuilder content: @escaping (A.Element) -> C){
        self.views = Array(array).map { content($0) }
        self.currentIndex = currentIndex
        self.currentPage = currentPage
    }
    
    @State private var indexToPoint: Int = 0
    private var showPoints: Bool = false
    private var style: PagesViewerPointStyle = _PointStyle.default
    private var forceMoveToNextPoint: Bool = true
    private var pointPosition: PageViewerPointPosition = .bottom

    public func pagePoints(_ showPoints: Bool) -> PageViewerView {
        var view = self
        view.showPoints = showPoints
        return view
    }
    
    public func pointsStyle(_ style: PagesViewerPointStyle) -> PageViewerView {
        var view = self
        view.style = style
        return view
    }
    
    public func forceMove(_ forceMoveToNextPoint: Bool) -> PageViewerView {
        var view = self
        view.forceMoveToNextPoint = forceMoveToNextPoint
        return view
    }
    
    public func pointPosition(_ position: PageViewerPointPosition) -> PageViewerView {
        var view = self
        view.pointPosition = position
        return view
    }
    
    public func pointPadding(_ padding: CGFloat) -> PageViewerView {
        var view = self
        view.style.padding = padding
        return view
    }
    
    private let currentIndex: Binding<Int>?
    private let currentPage: Binding<Int>?
    private let views: [C]
    
    @ViewBuilder private func getPoint(border: Color, fill: Color, size: CGFloat, borderSize: CGFloat) -> some View {
        ZStack{
            Circle()
                .fill(border)
            Circle()
                .fill(fill)
                .padding(borderSize)
                .blur(radius: 0.5)
        }
        .frame(width: size, height: size)
    }
    
    public var body: some View {
        switch pointPosition {
        case .bottom:
            VStack{
                PageViewerUIWrapper(forceMoveToNextPoint, views, currentIndex, currentPage, $indexToPoint)
                    
                self._viewPoints
                    .opacity(style._opacity)
                    .padding(.top, style._padding)
            }
        case .top:
            VStack{
                self._viewPoints
                    .opacity(style._opacity)
                    .padding(.bottom, style._padding)
                PageViewerUIWrapper(forceMoveToNextPoint, views, currentIndex, currentPage, $indexToPoint)
            }
        }
    }
    
    @ViewBuilder var _viewPoints: some View {
        if self.showPoints && views.count < 16 {
            Group{
                GeometryReader{ proxy in
                    HStack(spacing: style._spacing){
                        let size = (proxy.size.width / CGFloat(views.count)) - style._spacing
                        Spacer()
                        ForEach(0..<views.count, id: \.self){ item in
                                self.getPoint(
                                    border: indexToPoint == item ? style._borderActiveColor : style._borderInactiveColor,
                                    fill: indexToPoint == item ? style._bodyActiveColor : style._bodyInactiveColor,
                                    size: style._size > size ? size : style._size,
                                    borderSize: style._borderSize > size ? (size - 1) : style._borderSize
                                )
                                .animation(.spring(), value: indexToPoint)
                        }
                        Spacer()
                    }
                }
            }
            .frame(maxHeight: style._size + 5)
        } else {
            EmptyView()
        }
    }
}

public extension PageViewerView where A == [Any] {
    init(views: [C], currentIndex: Binding<Int>){
        self.views = views
        self.currentIndex = currentIndex
        self.currentPage = nil
    }
    init(views: [C], currentPage: Binding<Int>){
        self.views = views
        self.currentIndex = nil
        self.currentPage = nil
    }
    init(views: [C]){
        self.views = views
        self.currentIndex = nil
        self.currentPage = nil
    }
}

fileprivate struct _PointStyle: PagesViewerPointStyle {
    var opacity: CGFloat?
    var padding: CGFloat?
    var borderInactiveColor: Color?
    var bodyInactiveColor: Color?
    var bodyActiveColor: Color?
    var borderActiveColor: Color?
    var size: CGFloat?
    var borderSize: CGFloat?
    var spacing: CGFloat?
    
    static let `default`: _PointStyle = .init()
}
