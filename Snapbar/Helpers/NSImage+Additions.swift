//
//  Image+Additions.swift
//  Snapbar
//
//  Created by Jay Stakelon on 9/10/20.
//  Copyright © 2020 Jay Stakelon. All rights reserved.
//

import AppKit

extension NSImage {
    
    // not used
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
    
    // not used
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
    
    // from @raphaelhanneken
    // https://gist.github.com/raphaelhanneken/cb924aa280f4b9dbb480
    
    /// Resize the image to the given size.
    ///
    /// - Parameter size: The size to resize the image to.
    /// - Returns: The resized image.
    func resize(withSize targetSize: NSSize) -> NSImage? {
        let frame = NSRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height)
        guard let representation = self.bestRepresentation(for: frame, context: nil, hints: nil) else {
            return nil
        }
        let image = NSImage(size: targetSize, flipped: false, drawingHandler: { (_) -> Bool in
            return representation.draw(in: frame)
        })

        return image
    }
    
    /// Copy the image and resize it to the supplied size, while maintaining it's
    /// original aspect ratio.
    ///
    /// - Parameter size: The target size of the image.
    /// - Returns: The resized image.
    func resizeMaintainingAspectRatio(withSize targetSize: NSSize) -> NSImage? {
        let newSize: NSSize
        let widthRatio  = targetSize.width / self.size.width
        let heightRatio = targetSize.height / self.size.height
        if widthRatio < heightRatio {
            newSize = NSSize(width: floor(self.size.width * widthRatio),
                             height: floor(self.size.height * widthRatio))
        } else {
            newSize = NSSize(width: floor(self.size.width * heightRatio),
                             height: floor(self.size.height * heightRatio))
        }
        return self.resize(withSize: newSize)
    }
}
