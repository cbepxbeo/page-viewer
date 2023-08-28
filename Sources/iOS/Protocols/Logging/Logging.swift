/*
 
 Project: PageViewer
 File: Logging.swift
 Created by: Egor Boyko
 Date: 28.08.2023
 
 Status: #Complete | #Not decorated
 
 */

import OSLog

fileprivate let packageLogger: Logger = .init(
    subsystem: Bundle.main.bundleIdentifier ?? "",
    category: "page-viewer"
)

protocol Logging {}

extension Logging {
    func debugMessage(_ methodName: String, _ message: String){
        packageLogger.debug("\(self.createMessage(methodName, message))")
    }
    func warningMessage(_ methodName: String, _ message: String){
        packageLogger.warning("⚠️ \(self.createMessage(methodName, message))")
    }
    
    private func createMessage(_ methodName: String, _ message: String) -> String {
        let type = "\("\(Self.self)".split(separator: "<").first ?? "")"
        let method = "\(methodName.split(separator: "(").first ?? "")"
        return "[type: \(type)] [method: \(method)] \(message)"
    }
}
