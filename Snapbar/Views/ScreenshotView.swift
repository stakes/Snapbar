//
//  ScreenshotView.swift
//  Snapbar
//
//  Created by Jay Stakelon on 9/6/20.
//  Copyright © 2020 Jay Stakelon. All rights reserved.
//

import SwiftUI

struct ScreenshotView: View {
    @ObservedObject var viewModel: ScreenshotViewModel
    
    let timer = Timer.publish(
        every: 60, // second
        on: .main,
        in: .common
    ).autoconnect()
    @State var createdAtTimeAgo: String = ""
    
    var body: some View {
        Group {
            if (NSImage(contentsOf: viewModel.screenshot.url) != nil) {
                HStack {
                    Image(nsImage: NSImage(contentsOf: viewModel.screenshot.url)!).resizable().frame(width: 160, height: 90)
                    Text(self.createdAtTimeAgo)
                    .onReceive(timer) { (_) in
                        var timeStr = self.viewModel.screenshot.createdAt.relativeTime()
                        if timeStr.contains("seconds") {
                            timeStr = "Just now"
                        }
                        self.createdAtTimeAgo = timeStr
                    }.onAppear() {
                        var timeStr = self.viewModel.screenshot.createdAt.relativeTime()
                        if timeStr.contains("seconds") {
                            timeStr = "Just now"
                        }
                        self.createdAtTimeAgo = timeStr
                    }
                }.onDrag {
                    let data = NSImage(contentsOf: self.viewModel.screenshot.url)!
                    let provider = NSItemProvider(contentsOf: self.viewModel.screenshot.url)
                    provider?.previewImageHandler = { (handler, _, _) -> Void in
                        handler?(data as NSSecureCoding?, nil)
                    }
                    return provider!
                }
            } else {
                // missing image
                HStack {
                    Text("missing image")
                }
            }
        }
    }
}

//struct ScreenshotView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScreenshotView()
//    }
//}
