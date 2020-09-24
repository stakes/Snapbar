//
//  ScreenshotView.swift
//  Snapbar
//
//  Created by Jay Stakelon on 9/6/20.
//  Copyright © 2020 Jay Stakelon. All rights reserved.
//

import Foundation
import Cocoa
import SwiftUI

struct ScreenshotView: View {
    @ObservedObject var viewModel: ScreenshotViewModel
    @State var isHover: Bool = false
    var body: some View {
        
        HStack {
            if (NSImage(contentsOf: self.viewModel.screenshot.url) != nil) {
                HStack {
                    ZStack(alignment: .bottomLeading) {
                        Image(nsImage: NSImage(contentsOf: self.viewModel.screenshot.url)!.resizedTo(height: 100))
                            .onDrag {
                                let data = NSImage(contentsOf: self.viewModel.screenshot.url)!
                                let provider = NSItemProvider(contentsOf: self.viewModel.screenshot.url)
                                provider?.previewImageHandler = { (handler, _, _) -> Void in
                                    handler?(data as NSSecureCoding?, nil)
                                }
                                return provider!
                            }
    //                        .layoutPriority(-1)
                        if isHover {
                            Rectangle()
                                .foregroundColor(.clear)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0, blue: 0, opacity: 0), .black]), startPoint: .top, endPoint: .bottom)).opacity(0.2).cornerRadius(4).padding(0)
                                .allowsHitTesting(false)
                            Text(self.viewModel.screenshot.createdAt.relativeTime())
                                .font(.system(size: 12, weight: .regular, design: .default))
                                .foregroundColor(.white)
                                .opacity(self.isHover ? 1 : 0)
                                .padding(8)
                                .allowsHitTesting(false)
                        }
                    }.padding(8)
                }
                .background(
                    Rectangle()
                        .fill(isHover ? Color.white : Color.clear)
                        .cornerRadius(8)
                        .shadow(color: isHover ? Color.gray : Color.clear, radius: 2, x: 0, y: 0))
                        .padding(4)
                .onHover { hover in
                    self.isHover = hover
                }
                .animation(.default).focusable()
                
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
        }
    }
}

//struct ScreenshotView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestView()
//    }
//}

