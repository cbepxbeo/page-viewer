/*
 
 Project: PageViewer
 File: PageViewRepresentable+Method+MakeCoordinator.swift
 Created by: Egor Boyko
 Date: 24.08.2023
 
 Status: #Complete | #Not decorated
 
 */

import SwiftUI

extension PageViewRepresentable {
    func makeCoordinator() -> Coordinator<Content> {
        let coordinator = Coordinator(
            views: self.views,
            index: self.index,
            externalDelegate: self.delegate,
            looped: self.looped
        )
        self.controller?.pageViewCoordinator = .init(coordinator: coordinator)
        return coordinator
    }
}
