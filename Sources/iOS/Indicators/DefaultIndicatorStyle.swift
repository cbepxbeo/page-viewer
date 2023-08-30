/*
 
 Project: PageViewer
 File: DefaultIndicatorStyle.swift
 Created by: Egor Boyko
 Date: 29.08.2023
 
 Status: #Complete | #Not decorated
 
 */

import SwiftUI


public struct IndicatorsConfiguration<Style: IndicatorStyle>: View {
    let range: Range<Int>
    let index: Int?
    let style: () -> Style
    public var body: some View {
        ForEach(range, id: \.self){ index in
            IndicatorStorage(
                index: index,
                selected: index == self.index,
                style: style
            )
        }
    }
}

public struct DefaultIndicatorStyle: IndicatorStyle {

    public init(){}
    public func makeIndicator(selected: Bool, index: Int) -> some View {
        ZStack{
            Color.red.opacity(selected ? 1: 0.5)
                .animation(.spring(), value: selected)
        }
        .frame(width: 50, height: 50)
    }
 
    public func makeConfiguredPageView(content: () -> Content, indicators: () -> Indicators) -> some View {
            ZStack{
                content()
                HStack{
                    indicators()
                }
            }
    }
}
    
//    public func makeConfiguredPageView(content: () -> Content, indicators: () -> Indicators) -> some View {
//        Color.red
//    }

//    func makeConfiguredPageView(
//        content: () -> Content,
//        indicators: () -> Indicators) -> some View {
//        ZStack{
//            content()
//            HStack{
//                indicators()
//            }
//        }
//    }


//public struct Her: IndicatorStyle {
//    public func makeIndicator(selected: Bool, index: Int) -> some View {
//        ZStack{
//            Color.red.opacity(selected ? 1: 0.5)
//                .animation(.spring(), value: selected)
//        }
//        .frame(width: 50, height: 50)
//    }
//    func makeConfiguredPageView(
//        content: () -> Content,
//        indicators: () -> Indicator) -> some View {
//
//        }
//
////    public func makeConfiguredPageView<PageView: View, Indicators: View>(
////        content: () -> PageView,
////        indicators: () -> Indicators) -> some View {
////        ZStack{
////            content()
////            HStack{
////                indicators()
////            }
////        }
////    }
//    public func makeConfiguredPageView() -> some View {
//        Color.red
//    }
//}


