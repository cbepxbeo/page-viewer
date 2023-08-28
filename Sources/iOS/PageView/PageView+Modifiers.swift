/*
 
 Project: PageViewer
 File: PageView+Modifiers.swift
 Created by: Egor Boyko
 Date: 25.08.2023
 
 Status: #Complete | #Not decorated
 
 */

import SwiftUI

extension PageView {
    public func delegate(_ value: PageViewDelegate?) -> Self {
        var view = self
        view.delegate = value
        return view
    }
    public func controller(_ value: PageViewController?) -> Self {
        var view = self
        view.controller = value
        return view
    }
    public func scrollEnabled(_ value: Bool) -> Self {
        var view = self
        view.scrollEnabled = value
        return view
    }
    public func looped(_ value: Bool) -> Self {
        var view = self
        view.looped = value
        return view
    }
}
