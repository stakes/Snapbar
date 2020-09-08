//
//  ScreenshotViewModel.swift
//  Snapbar
//
//  Created by Jay Stakelon on 9/6/20.
//  Copyright © 2020 Jay Stakelon. All rights reserved.
//

import Foundation

class ScreenshotViewModel: ObservableObject, Identifiable {
    @Published var screenshot: Screenshot

    init(screenshot: Screenshot) {
        self.screenshot = screenshot
    }
}
