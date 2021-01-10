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
            VStack {
                ForEach(self.viewModel.screenshots.reversed()) { screenshot in
                    ScreenshotView(viewModel: ScreenshotViewModel(screenshot: screenshot))
                        .frame(width: 200)
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
