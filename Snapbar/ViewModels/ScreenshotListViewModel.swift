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
        let s = Screenshot(url: movedUrl)
        self.screenshots.append(s)
    }
    
    func clearScreenshots() {
        FileHandler.shared.removeAllFiles()
        self.screenshots = []
    }
}
