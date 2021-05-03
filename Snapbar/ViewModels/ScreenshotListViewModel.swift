//
//  ScreenshotListViewModel.swift
//  Snapbar
//
//  Created by Jay Stakelon on 9/6/20.
//  Copyright © 2020 Jay Stakelon. All rights reserved.
//

import Foundation
import AppKit

class ScreenshotListViewModel: ObservableObject {
    @Published var screenshots: [Screenshot] {
        didSet {
            try? UserDefaults.standard.set(JSONEncoder().encode(screenshots), forKey: "screenshots")
        }
        // whenever this changes
        willSet {
            // resize
        } 
    }
    
    let listMax:Int = 5 // maybe make this configurable someday
    
    init() {
        var arr:[Screenshot]
        if let data = UserDefaults.standard.data(forKey: "screenshots") {
            do {
                try arr = JSONDecoder().decode([Screenshot].self, from: data)
            } catch {
                arr = [Screenshot]()
            }
        } else {
            arr = [Screenshot]()
        }
        self.screenshots = arr
        self.cleanBrokenScreenshots()
    }
    
    func cleanBrokenScreenshots() {
        self.screenshots.removeAll { NSImage(contentsOf: $0.url) == nil }
    }
    
    func addScreenshot(_ url:URL) {
        self.cleanBrokenScreenshots()
        let movedUrl = FileHandler.shared.moveToSnapbarDirectory(url)
        copyImageAtUrlToClipboard(movedUrl)
        let s = Screenshot(url: movedUrl, createdAt: Date())
        self.screenshots.append(s)
        if (self.screenshots.count == self.listMax+1) {
            self.clearScreenshotAt(0)
        }
    }
    
    func copyImageAtUrlToClipboard(_ url:URL) {
        let image = NSImage(contentsOf: url)!
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.writeObjects([image])
    }
    
    func clearScreenshotAt(_ index: Int) {
        let screenshot = self.screenshots[index]
        FileHandler.shared.removeFileAtUrl(screenshot.url)
        self.screenshots.remove(at: index)
    }

    func clearScreenshots() {
        FileHandler.shared.removeAllFiles()
        self.screenshots = []
    }
}
