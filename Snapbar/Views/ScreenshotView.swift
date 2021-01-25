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
    let screenshotSize:CGSize = CGSize(width: 100, height: 100)
    var body: some View {
        
        HStack {
            if (NSImage(contentsOf: self.viewModel.screenshot.url) != nil) {
                ZStack(alignment: .bottomLeading) {
                    Image(nsImage: NSImage(contentsOf: self.viewModel.screenshot.url)!.resizeMaintainingAspectRatio(withSize: CGSize(width: screenshotSize.width, height: screenshotSize.height-12))!)
//                        .overlay(
//                            LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0, blue: 0, opacity: 0), Color(red: 0, green: 0, blue: 0, opacity: 0.4)]), startPoint: .top, endPoint: .bottom)
//                                .opacity(self.isHover ? 1 : 0)
//                        )
//                        .padding(.vertical, 8)
                        .onDrag {
                            let data = NSImage(contentsOf: self.viewModel.screenshot.url)!
                            let provider = NSItemProvider(contentsOf: self.viewModel.screenshot.url)
                            provider?.previewImageHandler = { (handler, _, _) -> Void in
                                handler?(data as NSSecureCoding?, nil)
                            }
                            return provider!
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
//                    Text(self.viewModel.screenshot.createdAt.relativeTime())
//                        .font(.system(size: 12, weight: .regular, design: .default))
//                        .foregroundColor(.white)
//                        .opacity(self.isHover ? 1 : 0)
//                        .padding(.vertical, self.isHover ? 24 : 16)
//                        .padding(.horizontal, 16)
//                        .allowsHitTesting(false)
//                        .animation(Animation.easeOut.delay(0.1))
                }.onHover { hover in
                    self.isHover = hover
                }
                .frame(width: screenshotSize.width, height: screenshotSize.height)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                .padding(4)
                .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Color("HighlightBorderColor").opacity(isHover ? 1 : 0), lineWidth: 2))
                .padding(4)
                .background(Color("HighlightColor").opacity(isHover ? 1 : 0))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
//                .animation(.linear(duration: 0.05))
            }
        }
    }
}

//struct ScreenshotView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestView()
//    }
//}

