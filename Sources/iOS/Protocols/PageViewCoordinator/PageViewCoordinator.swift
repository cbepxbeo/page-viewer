/*
 
 Project: PageViewer
 File: PageViewCoordinator.swift
 Created by: Egor Boyko
 Date: 24.08.2023
 
 Status: #Completed | #Not required
 
 */

import UIKit

protocol PageViewCoordinator: AnyObject {
    func goTo(_ option: CoordinatorOption)
    var scrollView: UIScrollView? { get }
    var scrollEnabled: Bool { get set }
}
