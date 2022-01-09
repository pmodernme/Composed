//
//  CIImageConvenience.swift
//  ZVBUIUtilities
//
//  Created by Zoe Van Brunt on 6/25/19.
//  Copyright © 2019 Zoe Van Brunt. All rights reserved.
//

import CoreImage

extension CIImage {
    /// Inverts the colors and creates a transparent image by converting the mask to alpha.
    /// Input image should be black and white.
    var transparent: CIImage? {
        return inverted?.blackTransparent
    }
    
    /// Inverts the colors.
    var inverted: CIImage? {
        guard let invertedColorFilter = CIFilter(name: "CIColorInvert") else { return nil }
        
        invertedColorFilter.setValue(self, forKey: "inputImage")
        return invertedColorFilter.outputImage
    }
    
    /// Converts all black to transparent.
    var blackTransparent: CIImage? {
        guard let blackTransparentFilter = CIFilter(name: "CIMaskToAlpha") else { return nil }
        blackTransparentFilter.setValue(self, forKey: "inputImage")
        return blackTransparentFilter.outputImage
    }
    
    /// Applies the given color as a tint color.
    func tinted(using color: CIColor) -> CIImage?
    {
        guard let transparentQRImage = transparent,
              let filter = CIFilter(name: "CIMultiplyCompositing"),
              let colorFilter = CIFilter(name: "CIConstantColorGenerator") else { return nil }
        
        colorFilter.setValue(color, forKey: kCIInputColorKey)
        let colorImage = colorFilter.outputImage
        
        filter.setValue(colorImage, forKey: kCIInputImageKey)
        filter.setValue(transparentQRImage, forKey: kCIInputBackgroundImageKey)
        
        return filter.outputImage!
    }
}
