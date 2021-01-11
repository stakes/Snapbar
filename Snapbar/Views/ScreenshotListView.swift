//
//  ScreenshotListView.swift
//  Snapbar
//
//  Created by Jay Stakelon on 9/6/20.
//  Copyright © 2020 Jay Stakelon. All rights reserved.
//

import SwiftUI

struct ScreenshotListView: View {
    @ObservedObject var viewModel: ScreenshotListViewModel
    var body: some View {
        VStack {
            if (self.viewModel.screenshots.count == 0) {
                VStack {
                    Text("📸").font(.system(size: 36, weight: .regular, design: .default)).padding(.bottom, 2)
                    Text("Take some screenshots")
                    Text("And they'll show up here")
                }.frame(width: 200, height: 180)
            } else {
                VStack {
                    ForEach(self.viewModel.screenshots.reversed()) { screenshot in
                        ScreenshotView(viewModel: ScreenshotViewModel(screenshot: screenshot))
                            .frame(width: 200)
                    }
                }
            }
        }
    }
}


//struct ScreenshotListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScreenshotListView()
//    }
//}
