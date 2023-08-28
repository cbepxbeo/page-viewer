/*
 
 Project: PageViewer
 File: Coordinator.swift
 Created by: Egor Boyko
 Date: 25.08.2023
 
 Status: #Complete | #Not decorated
 
 */

import SwiftUI

final class Coordinator<Content: View>: PageViewCoordinator, Logging {
//    init(
//        views: [Content],
//        index: Binding<Int>?) {
//            self.externalDelegate = nil
//            self.externalController = nil
//            self.dataSource = .init(
//                views: views,
//                lastIndex: index?.wrappedValue ?? 0,
//                looped: false
//            )
//            self.delegate = .init()
//            self.index = index
//            externalDelegate?.total = dataSource.total
//            self.indexQuene = []
//            self.locked = false
//            self.animated = false
//            self.scrollEnabled = true
//            self.dataSource.coordinator = self
//            self.delegate.coordinator = self
//        }
    
    var dataSource: DataSource<Content> = .init()
    var delegate: Delegate<Content> = .init()
    var scrollEnabled: Bool = true
    var index: Binding<Int>? = nil
    var indexQuene: [Int] = []
    var locked: Bool = false
    var animated: Bool = false
    weak var externalDelegate: PageViewDelegate? = nil
    weak var externalController: PageViewController? = nil
    weak var scrollView: UIScrollView? = nil
    weak var pageViewController: UIPageViewController? = nil
}
