/*
 
 Project: PageViewer
 File: PageViewRepresentable+Method+MakeCoordinator.swift
 Created by: Egor Boyko
 Date: 24.08.2023
 
 Status: #Completed | #Not required
 
 */

import SwiftUI

extension PageViewRepresentable {
    func makeCoordinator() -> Coordinator<Content> {
        self.debugMessage(#function, "Call")
        /*
         We return the unconfigured coordinator so that the optimizer saves it.
         After setting up the view, the update method will be called, and the main
         settings will be performed in it.
         */
        return .init()
    }
}
