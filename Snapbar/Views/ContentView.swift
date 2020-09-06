//
//  ContentView.swift
//  Snapbar
//
//  Created by Jay Stakelon on 9/5/20.
//  Copyright © 2020 Jay Stakelon. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Group {
            ScreenshotListView(viewModel: ScreenshotListViewModel())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

