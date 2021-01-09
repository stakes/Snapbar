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
                    Image(nsImage: self.resizeImage(image: NSImage(contentsOf: self.viewModel.screenshot.url)!, maxSize: NSSize(width: 178, height: 178)))
//                        .resizable()
//                        .frame(width: 178, height: 178)
//                        .aspectRatio(contentMode: .fit)
                        .mask(
                        VStack {
                            Rectangle().cornerRadius(4).frame(width: 178, height: 178)
                        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center))
                        .padding(8)
                    if isHover {
                        Rectangle()
                            .foregroundColor(.clear)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0, blue: 0, opacity: 0), .black]), startPoint: .top, endPoint: .bottom)).opacity(0.2).cornerRadius(4).padding(8)
                        Text("Just now")
                            .font(.system(size: 12, weight: .regular, design: .default))
                            .foregroundColor(.white)
                            .opacity(self.isHover ? 1 : 0)
                            .padding(16)
                    }
                }.onDrag {
                    let data = NSImage(contentsOf: self.viewModel.screenshot.url)!
                    let provider = NSItemProvider(contentsOf: self.viewModel.screenshot.url)
                    provider?.previewImageHandler = { (handler, _, _) -> Void in
                        handler?(data as NSSecureCoding?, nil)
                    }
                    return provider!
                }
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
    
    

    // Function for resizing an NSImage
    // Parameters:
    //      image:NSImage -> The NSImage that will be resized
    //      maxSize:NSSize -> An NSSize object that will define the new size of the image
    func resizeImage(image:NSImage, maxSize:NSSize) -> NSImage {
        var ratio:Float = 0.0
        var newWidth:Float = 0.0
        var newHeight:Float = 0.0
        let imageWidth = Float(image.size.width)
        let imageHeight = Float(image.size.height)
        let maxWidth = Float(maxSize.width)
        let maxHeight = Float(maxSize.height)
        
        
        // Get ratio (landscape or portrait)
        if (imageWidth > imageHeight) {
            // Landscape
            ratio = maxWidth / imageWidth
            newWidth = imageWidth * ratio
            newHeight = imageHeight * ratio
        }
        else {
            // Portrait
            ratio = maxHeight / imageHeight
            newWidth = imageWidth * ratio
            newHeight = maxHeight
        }
        
        // Calculate new size based on the ratio
//        let newWidth = imageWidth * ratio
//        let newHeight = imageHeight * ratio
        
        // Create a new NSSize object with the newly calculated size
        let newSize:NSSize = NSSize(width: Int(newWidth), height: Int(newHeight))
        
        // Cast the NSImage to a CGImage
        var imageRect:CGRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        let imageRef = image.cgImage(forProposedRect: &imageRect, context: nil, hints: nil)
        
        // Create NSImage from the CGImage using the new size
        let imageWithNewSize = NSImage(cgImage: imageRef!, size: newSize)
        
        // Return the new image
        return imageWithNewSize
    }
}

//struct TestView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestView()
//    }
//}
