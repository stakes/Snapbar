//
//  ScreenshotListViewModel.swift
//  Snapbar
//
//  Created by Jay Stakelon on 9/6/20.
//  Copyright © 2020 Jay Stakelon. All rights reserved.
//

import Foundation

class ScreenshotListViewModel: ObservableObject {
    @Published var screenshots: [Screenshot] {
        didSet {
            try? UserDefaults.standard.set(JSONEncoder().encode(screenshots), forKey: "screenshots")
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
    }
    
    func addScreenshot(_ url:URL) {
        let movedUrl = FileHandler.shared.moveToSnapbarDirectory(url)
        let s = Screenshot(url: movedUrl, createdAt: Date())
        self.screenshots.append(s)
        if (self.screenshots.count == self.listMax+1) {
            self.clearScreenshotAt(0)
        }
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
