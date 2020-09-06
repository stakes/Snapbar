//
//  FileHandler.swift
//  Snapbar
//
//  Created by Jay Stakelon on 9/6/20.
//  Copyright © 2020 Jay Stakelon. All rights reserved.
//

import Foundation

class FileHandler: ObservableObject {
    
    static let shared = FileHandler()
    var destination:URL?
    
    init() {
        createSnapbarDirectory()
    }
    
    func createSnapbarDirectory() {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let docURL = URL(string: documentsDirectory)!
        destination = docURL.appendingPathComponent("Snapbar")
        if !FileManager.default.fileExists(atPath: destination!.absoluteString) {
            do {
                try FileManager.default.createDirectory(atPath: destination!.absoluteString, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription);
            }
        }
    }
    
    func moveToSnapbarDirectory(_ url:URL) {
        print("moveToSnapbarDirectory")
        print(url.absoluteString)
    }
}
