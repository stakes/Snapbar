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
    
    let timer = Timer.publish(
        every: 60, // second
        on: .main,
        in: .common
    ).autoconnect()
    @State var createdAtTimeAgo: String = ""
    @State var isHover: Bool = false
    
    var body: some View {
        HStack {
            if (NSImage(contentsOf: viewModel.screenshot.url) != nil) {
                VStack(alignment: .leading) {
                    HStack {
                            Image(nsImage: NSImage(contentsOf: self.viewModel.screenshot.url)!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 160)
//                                .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                    }.onDrag {
                        let data = NSImage(contentsOf: self.viewModel.screenshot.url)!
                        let provider = NSItemProvider(contentsOf: self.viewModel.screenshot.url)
                        provider?.previewImageHandler = { (handler, _, _) -> Void in
                            handler?(data as NSSecureCoding?, nil)
                        }
                        return provider!
                    }.onHover { over in
                        self.isHover = over
                    }.background(Color.red)
                    Text(self.createdAtTimeAgo)
                        .font(.system(size: 12, weight: .medium, design: .default))
                        .foregroundColor(.gray)
                        .opacity(self.isHover ? 1 : 0)
//                    .offset(x: -10, y: -10)
                        .onReceive(timer) { (_) in
                            var timeStr = self.viewModel.screenshot.createdAt.relativeTime()
                            if timeStr.contains("seconds") {
                                timeStr = "Just now"
                            }
                            self.createdAtTimeAgo = timeStr
                        }.onAppear() {
                            var timeStr = self.viewModel.screenshot.createdAt.relativeTime()
                            if timeStr.contains("seconds") {
                                timeStr = "Just now"
                            }
                            self.createdAtTimeAgo = timeStr
                        }
                }
            } else {
                // missing image
                HStack {
                    Spacer()
                    VStack {
                        Text("🤷‍♀️").padding(.bottom, 6).font(.system(size: 21))
                        Text("Missing image")
                            .font(.system(size: 12, weight: .medium, design: .default))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }.frame(width: 160, height: 90)
            }
        }.frame(width: 200, height: 112)
    }
}

//struct ScreenshotView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScreenshotView()
//    }
//}
