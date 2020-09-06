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
        }
    }
}

//struct ScreenshotView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScreenshotView()
//    }
//}
