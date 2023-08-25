/*
 
 Project: PageViewer
 File: PageViewController.swift
 Created by: Egor Boyko
 Date: 26.08.2023
 
 Status: #Complete | #Not decorated
 
 */

///The protocol provides an implementation of the default methods for interacting with the view
public protocol PageViewController: AnyObject {
    var pageViewCoordinator: CoordinatorStorage? { get set }
}
