/*
 
 Project: PageViewer
 File: Coordinator.swift
 Created by: Egor Boyko
 Date: 25.08.2023
 
 Status: #Complete | #Not decorated
 
 */

import SwiftUI

final class Coordinator<Content: View>: PageViewCoordinator, Logging {
    init(
        views: [Content],
        index: Binding<Int>?,
        externalDelegate: PageViewDelegate? = nil,
        looped: Bool) {
            self.externalDelegate = externalDelegate
            self.dataSource = .init(
                views: views,
                lastIndex: index?.wrappedValue ?? 0,
                looped: looped
            )
            self.delegate = .init()
            self.index = index
            externalDelegate?.total = dataSource.total
            self.indexQuene = []
            self.locked = false
            self.animated = false
            self.scrollDisabled = false
            self.dataSource.coordinator = self
            self.delegate.coordinator = self
        }
    
    weak var externalDelegate: PageViewDelegate?
    let dataSource: DataSource<Content>
    let delegate: Delegate<Content>
    weak var scrollView: UIScrollView?
    weak var pageViewController: UIPageViewController?
    var scrollDisabled: Bool
    let index: Binding<Int>?
    var indexQuene: [Int]
    var locked: Bool
    var animated: Bool
}
