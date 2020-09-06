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
    var body: some View {
        HStack {
            Image(nsImage: NSImage(contentsOf: viewModel.screenshot.url)!).resizable().frame(width: 160, height: 90)
        }.onDrag {
            let data = NSImage(contentsOf: self.viewModel.screenshot.url)!
            let provider = NSItemProvider(contentsOf: self.viewModel.screenshot.url)
            provider?.previewImageHandler = { (handler, _, _) -> Void in
                handler?(data as NSSecureCoding?, nil)
            }
            return provider!
        }
    }
}

//struct ScreenshotView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScreenshotView()
//    }
//}
