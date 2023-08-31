/*
 
 Project: PageViewer
 File: PageViewDelegate.swift
 Created by: Egor Boyko
 Date: 25.08.2023
 
 Status: #Complete | #Decorated
 
 */

///Use a protocol if you want to receive calls about events in the PageView
public protocol PageViewDelegate: AnyObject {
    ///Gets the index of the current view after the transition completes
    ///- Parameter index: index of the current view.
    ///- Note: The method is executed on the main thread
    func indexAfterAnimation(_ index: Int)
    ///Called at the start of a transition gesture
    ///- Parameter pendingIndex: Index of the view being jumped to
    ///- Note: The method is not executed on the main thread.
    ///If you plan to perform actions to update the view, then do it on the main thread.
    func willTransition(_ pendingIndex: Int)
    ///The method is called after the transition has been executed and the animation has completed.
    ///- Parameter completed: Indicates the end of the transition. If the user started the gesture but didn't finish,
    ///the value will be false.
    ///- Note: The method is executed on the main thread
    func didFinishAnimating(_ completed: Bool)
}
