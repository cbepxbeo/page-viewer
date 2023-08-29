/*
 
 Project: PageViewer
 File: Deprecated.swift
 Created by: Egor Boyko
 Date: 24.08.2023
 
 Status: #Completed | #Not required
 
 */

@available(*,deprecated, renamed: "PageView", message: "Will not be available in the next version")
typealias PageViewerView = PageView


extension PageView {
    @available(*,deprecated, renamed: "looped", message: "Will not be available in the next version")
    public func setCarouselMode(_ isCarousel: Bool) -> PageView {
        var view = self
        view.looped = isCarousel
        return view
    }
    @available(*,deprecated, message: "The method lost relevance and did not perform any actions. Will not be available in the next version")
    public func forceMove(_ forceMoveToNextPoint: Bool) -> PageView {
        self
    }
    
}
