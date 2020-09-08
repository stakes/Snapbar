//
//  ContentView.swift
//  Snapbar
//
//  Created by Jay Stakelon on 9/5/20.
//  Copyright © 2020 Jay Stakelon. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ScreenshotListViewModel
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.viewModel.clearScreenshots()
                }) {
                    Text("Clear")
                }
            }
            ScreenshotListView(viewModel: viewModel)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

