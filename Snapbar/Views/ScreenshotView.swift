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
    @State var isSelected: Bool = false
    var body: some View {
        
        HStack {
            if (NSImage(contentsOf: self.viewModel.screenshot.url) != nil) {
  
                ZStack(alignment: .bottomLeading) {
                    Image(nsImage: NSImage(contentsOf: self.viewModel.screenshot.url)!.resizedTo(height: 100))
                        .overlay(
                            LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0, blue: 0, opacity: 0), Color(red: 0, green: 0, blue: 0, opacity: isHover ? 0.4 : 0)]), startPoint: .top, endPoint: .bottom))
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        .padding(4)
                        .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Color.white.opacity(isHover ? 0.2 : 0), lineWidth: 2))
                        .padding(4)
                        .background(Color.blue.opacity(isHover ? 0.2 : 0))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .padding(.vertical, 8)
                        .onDrag {
                            let data = NSImage(contentsOf: self.viewModel.screenshot.url)!
                            let provider = NSItemProvider(contentsOf: self.viewModel.screenshot.url)
                            provider?.previewImageHandler = { (handler, _, _) -> Void in
                                handler?(data as NSSecureCoding?, nil)
                            }
                            return provider!
                        }
                    if isHover {
                        Text(self.viewModel.screenshot.createdAt.relativeTime())
                            .font(.system(size: 12, weight: .regular, design: .default))
                            .foregroundColor(.white)
                            .opacity(self.isHover ? 1 : 0)
                            .padding(.vertical, 24)
                            .padding(.horizontal, 16)
                            .allowsHitTesting(false)
                    }
                }.onHover { hover in
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

