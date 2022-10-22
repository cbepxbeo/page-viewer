//
// Project: PageViewer
// File: PageViewerView.swift
// Created by: Egor Boyko
// Date: 21.10.2022
//
// Status: #In progress | #Not decorated
//
import SwiftUI

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
        self.__indexToPoint = State(initialValue: 0)
    }
    
    private init(_ array: A, currentIndex: Binding<Int>? = nil, currentPage: Binding<Int>? = nil, @ViewBuilder content: @escaping (A.Element) -> C){
        self.views = Array(array).map { content($0) }
        self.currentIndex = currentIndex
        self.currentPage = currentPage
        self.__indexToPoint = State(initialValue: 0)
    }
    

    @State private var _indexToPoint: Int
    private let currentIndex: Binding<Int>?
    private let currentPage: Binding<Int>?
    private let views: [C]
    
    var indexToPoint: Int {
        if currentIndex != nil {
            return currentIndex!.wrappedValue
        } else if currentPage != nil {
            return currentPage!.wrappedValue - 1
        } else {
            return _indexToPoint
        }
    }
    
    private func getPoint(border: Color, fill: Color) -> some View {
        ZStack{
            Circle()
                .fill(border)
            Circle()
                .fill(fill)
                .padding(1)
        }
        .frame(width: 20, height: 20)
    }
    
    public var body: some View {
        viewer
        HStack{
            ForEach(0..<views.count, id: \.self){ item in
                self.getPoint(border: .black, fill: indexToPoint == item ? .gray : .white)
                    .animation(.spring(), value: indexToPoint)
            }
        }
    }
    
    @ViewBuilder var viewer: some View {
        if currentIndex == nil && currentPage == nil {
            PageViewerUIWrapper(views, $_indexToPoint, nil)
        } else {
            PageViewerUIWrapper(views, currentIndex, currentPage)
        }
    }
    
}

extension PageViewerView where A == [Any] {
    init(views: [C], currentIndex: Binding<Int>){
        self.views = views
        self.currentIndex = currentIndex
        self.currentPage = nil
        self.__indexToPoint = State(initialValue: 0)
    }
    init(views: [C], currentPage: Binding<Int>){
        self.views = views
        self.currentIndex = nil
        self.currentPage = nil
        self.__indexToPoint = State(initialValue: 0)
    }
    init(views: [C]){
        self.views = views
        self.currentIndex = nil
        self.currentPage = nil
        self.__indexToPoint = State(initialValue: 0)
    }
}




