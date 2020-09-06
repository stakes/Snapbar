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
            List {
                ForEach(viewModel.screenshots) { screenshot in
                    ScreenshotView(viewModel: ScreenshotViewModel(screenshot: screenshot))
                    Text(self.viewModel.screenshots.description)
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
