//
//  TestView.swift
//  Snapbar
//
//  Created by Jay Stakelon on 9/12/20.
//  Copyright © 2020 Jay Stakelon. All rights reserved.
//


import Foundation
import Cocoa
import SwiftUI

struct TestView: View {
    @ObservedObject var viewModel: ScreenshotViewModel
    @State var isHover: Bool = false
    var body: some View {
        
        HStack {
        
        if (NSImage(contentsOf: self.viewModel.screenshot.url) != nil) {
        
            HStack {
                ZStack(alignment: .bottomLeading) {
                    Image(nsImage: NSImage(contentsOf: self.viewModel.screenshot.url)!.resizedTo(width: 178, maxHeight: 178))
//                        .resizable()
//                        .frame(width: 198, height: 198)
//                        .aspectRatio(contentMode: .fit)
//                        .mask(
//                        VStack {
//                            Rectangle().cornerRadius(4).frame(width: 178, height: 178)
//                        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center))
//                        .padding(-10)
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
                        Text("Just now")
                            .font(.system(size: 12, weight: .regular, design: .default))
                            .foregroundColor(.white)
                            .opacity(self.isHover ? 1 : 0)
                            .padding(8)
                            .allowsHitTesting(false)
                    }
                }.padding(8)
            }.background(
                Rectangle()
                    .fill(isHover ? Color(.white) : Color("cardDefault"))
                    .cornerRadius(8)
                    .shadow(color: isHover ? Color.gray : Color.clear, radius: 2, x: 0, y: 0))
                    .padding(4)
            .onHover { hover in
                self.isHover = hover
            }.animation(.default).focusable()
            
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

//struct TestView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestView()
//    }
//}

extension NSImage {
    func resizedTo(width: CGFloat, maxHeight: CGFloat) -> NSImage {
        let aspectRatio = CGFloat(self.size.width/self.size.height)
        let ogResizedHeight = CGFloat(ceil(width/size.width * size.height))
        let targetHeight = (ogResizedHeight > maxHeight) ? maxHeight : ogResizedHeight
        let canvasSize = CGSize(width: width, height: targetHeight)
        let img = NSImage(size: canvasSize)
        img.lockFocus()
        NSGraphicsContext.current?.imageInterpolation = .high
        if (aspectRatio < 1) {
            let blurredCopy = self.blur()
            blurredCopy.draw(in: NSRect(origin: CGPoint(x: -(width * 0.1), y: -(ogResizedHeight * 0.1)), size: CGSize(width: width*1.2, height: ogResizedHeight*1.2)), from: NSRect(origin: .zero, size: size), operation: .copy, fraction: 1)
            let ogImageSize = CGSize(width: ceil(maxHeight*aspectRatio), height: maxHeight)
            let imageOrigin = CGPoint(x: (width-ceil(maxHeight*aspectRatio))/2, y: 0)
            draw(in: NSRect(origin: imageOrigin, size: ogImageSize), from: NSRect(origin: .zero, size: size), operation: .copy, fraction: 1)
        } else {
            draw(in: NSRect(origin: .zero, size: canvasSize), from: NSRect(origin: .zero, size: size), operation: .copy, fraction: 1)
        }
        img.unlockFocus()
        return img
    }
    
    func blur() -> NSImage {
        let inputImage = CIImage(data: self.tiffRepresentation!)
        let filter = CIFilter(name: "CIGaussianBlur")
        filter!.setDefaults()
        filter!.setValue(inputImage, forKey: kCIInputImageKey)
        filter!.setValue(5, forKey: kCIInputRadiusKey)
        let outputImage = filter!.value(forKey: kCIOutputImageKey) as! CIImage
        let outputImageRect = NSRectFromCGRect(outputImage.extent)
        let blurredImage = NSImage(size: outputImageRect.size)
        blurredImage.lockFocus()
        outputImage.draw(at: NSZeroPoint, from: outputImageRect, operation: .copy, fraction: 1.0)
        blurredImage.unlockFocus()
        return blurredImage
    }
}
