//
//  Image+Additions.swift
//  Snapbar
//
//  Created by Jay Stakelon on 9/10/20.
//  Copyright © 2020 Jay Stakelon. All rights reserved.
//

import AppKit

extension NSImage {
    func resizedTo(height: CGFloat) -> NSImage {
        let aspectRatio = CGFloat(self.size.width/self.size.height)
        let canvasSize = CGSize(width: height*aspectRatio, height: height)
        let img = NSImage(size: canvasSize)
        img.lockFocus()
        NSGraphicsContext.current?.imageInterpolation = .high
        draw(in: NSRect(origin: .zero, size: canvasSize), from: NSRect(origin: .zero, size: size), operation: .copy, fraction: 1)
        img.unlockFocus()
        return img
    }
    
    func resizedTo(width: CGFloat) -> NSImage {
        let aspectRatio = CGFloat(self.size.height/self.size.width)
        let canvasSize = CGSize(width: width, height: width*aspectRatio)
        let img = NSImage(size: canvasSize)
        img.lockFocus()
        NSGraphicsContext.current?.imageInterpolation = .high
        draw(in: NSRect(origin: .zero, size: canvasSize), from: NSRect(origin: .zero, size: size), operation: .copy, fraction: 1)
        img.unlockFocus()
        return img
    }
    
    // not used
    func resizedToWithBlur(width: CGFloat, maxHeight: CGFloat) -> NSImage {
        let aspectRatio = CGFloat(self.size.width/self.size.height)
        let ogResizedHeight = CGFloat(ceil(width/size.width * size.height))
        let targetHeight = (ogResizedHeight > maxHeight) ? maxHeight : ogResizedHeight
        let canvasSize = CGSize(width: width, height: targetHeight)
        let img = NSImage(size: canvasSize)
        img.lockFocus()
        NSGraphicsContext.current?.imageInterpolation = .high
        if (aspectRatio < 1) {
            let ogImageSize = CGSize(width: ceil(maxHeight*aspectRatio), height: maxHeight)
            let imageOrigin = CGPoint(x: (width-ceil(maxHeight*aspectRatio))/2, y: 0)
            draw(in: NSRect(origin: imageOrigin, size: ogImageSize), from: NSRect(origin: .zero, size: size), operation: .copy, fraction: 1)
        } else {
            draw(in: NSRect(origin: .zero, size: canvasSize), from: NSRect(origin: .zero, size: size), operation: .copy, fraction: 1)
        }
        img.unlockFocus()
        return img
    }
    
    // also not used
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
