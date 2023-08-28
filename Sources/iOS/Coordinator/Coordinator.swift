/*
 
 Project: PageViewer
 File: Coordinator.swift
 Created by: Egor Boyko
 Date: 25.08.2023
 
 Status: #Complete | #Not decorated
 
 */

import SwiftUI

final class Coordinator<Content: View>: PageViewCoordinator, Logging {
    init(){
        self.delegate = .init()
        self.delegate.coordinator = self
    }
    var dataSource: DataSource<Content> = .init()
    var delegate: Delegate<Content>
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
