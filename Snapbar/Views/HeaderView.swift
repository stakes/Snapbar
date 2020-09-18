//
//  HeaderView.swift
//  Snapbar
//
//  Created by Jay Stakelon on 9/7/20.
//  Copyright © 2020 Jay Stakelon. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    @ObservedObject var viewModel: ScreenshotListViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Snapbar").font(Font.system(size: 18, weight: .bold, design: .default))
                Spacer()
                DropdownMenuView(viewModel: viewModel).frame(width: 48, height: 24)
            }.padding(12)
            Divider().background(Color.gray.opacity(0.1))
        }.background(Color.gray.opacity(0.1))
    }
}
//struct HeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        HeaderView()
//    }
//}
