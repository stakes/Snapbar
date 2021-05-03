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
                Text("Snapbar").font(Font.system(size: 12, weight: .bold, design: .rounded))
                Spacer()
                DropdownMenuView(viewModel: viewModel).frame(width: 24, height: 24)
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 12)
            Divider().background(Color.gray.opacity(0.1))
        }.background(Color(.windowBackgroundColor))
    }
}
//struct HeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        HeaderView()
//    }
//}
