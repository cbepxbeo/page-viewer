/*
 
 Project: PageViewer
 File: CoordinatorOption.swift
 Created by: Egor Boyko
 Date: 26.08.2023
 
 Status: #Complete | #Not decorated
 
 */

///Options for programmatic transition to view
public enum CoordinatorOption {
    ///Use to go to the first view
    case first
    ///Use to go to the last view
    case last
    ///Use to move to the next view
    case next
    ///Use to move to the previous view
    case previous
    ///Use if you want go to  a view with a specific index
    ///- Note: If the index is out of range, the transition will not occur.
    case index(Int)
}
