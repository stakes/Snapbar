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
        VStack(alignment: .leading) {
            HeaderView(viewModel: viewModel)
            ScreenshotListView(viewModel: viewModel)
                .padding(.top, -8)
                .background(
                    GeometryReader { geo in
                        Color.clear.onAppear {
                            po.contentSize = geo.size
                        }
                    }
                )
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

