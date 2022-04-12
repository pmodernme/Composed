//
//  QRImage.swift
//  ZVBUIUtilities
//
//  Created by Zoe Van Brunt on 6/25/19.
//  Copyright © 2019 Zoe Van Brunt. All rights reserved.
//

#if canImport(UIKit)

import UIKit

public extension UIImage {
    convenience init?(qrCodeString dataStr: String) {
        
        guard let data = dataStr.data(using: .ascii),
              let qrFilter = CIFilter(
                name: "CIQRCodeGenerator",
                parameters: [
                    "inputMessage": data,
                    "inputCorrectionLevel": "L"
                ]
              ),
              let qrImage = qrFilter.outputImage
        else { return nil }
        
        self.init(ciImage: qrImage, scale: 1/4, orientation: .up)
    }
}

public extension String {
    func qrCode() -> UIImage? {
        return UIImage(qrCodeString: self)
    }
}

public extension URL {
    func qrCode() -> UIImage? {
        return UIImage(qrCodeString: absoluteString)
    }
}

#endif
