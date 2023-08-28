/*
 
 Project: PageViewer
 File: PageViewDelegate.swift
 Created by: Egor Boyko
 Date: 25.08.2023
 
 Status: #Completed | #Not required
 
 */

///Use a protocol if you want to receive calls about events in the PageView
public protocol PageViewDelegate: AnyObject {
    var total: Int { get set }
    func indexAfterAnimation(_ index: Int)
}
