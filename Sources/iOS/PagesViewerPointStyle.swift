//
// Project: PageViewer
// File: PagesViewerPointStyle.swift
// Created by: Egor Boyko
// Date: 22.10.2022
//
// Status: #In progress | #Not decorated
//
import SwiftUI

public protocol PagesViewerPointStyle {
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

extension PagesViewerPointStyle {
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
        if self.borderSize == nil { return 1 }
        return self._size > self.borderSize! ? self._borderSize : (self._size - 1)
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
