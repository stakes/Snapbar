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
        if !FileManager.default.fileExists(atPath: destination!.path) {
            do {
                try FileManager.default.createDirectory(atPath: destination!.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription);
            }
        }
    }
    
    func moveToSnapbarDirectory(_ url:URL) -> URL {
        let fileManager = FileManager.default
        let destUrl = URL(fileURLWithPath: (destination?.appendingPathComponent(url.lastPathComponent).path)!)
        if fileManager.fileExists(atPath: url.path) {
            do {
                try fileManager.moveItem(at: url, to: destUrl)
            } catch let error {
                // probably handle idk
                print(error)
            }
        }
        return destUrl
    }
    
    func removeFile() {
        
    }
    
    func removeAllFiles() {
        let fileManager = FileManager.default
        do {
            let urls = try fileManager.contentsOfDirectory(atPath: destination!.path)
            for url in urls {
                let fileUrl = URL(fileURLWithPath: (destination?.appendingPathComponent(url).path)!)
                try FileManager.default.removeItem(atPath: fileUrl.path)
            }
        } catch  {
            // probably handle idk
            print(error)
        }
    }
    
}
