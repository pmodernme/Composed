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
    convenience init?(qrCodeString dataStr: String, size factor: CGFloat = 3, color: UIColor = .black) {
        
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        let data = dataStr.data(using: .ascii)
        qrFilter.setValue(data, forKey: "inputMessage")
        guard let qrImage = qrFilter.outputImage?.tinted(using: CIColor(color: color)) else { return nil }
        
        let transform = CGAffineTransform(scaleX: factor, y: factor)
        self.init(ciImage: qrImage.transformed(by: transform))
    }
}

public extension String {
    func qrCode(size factor: CGFloat = 3, color: UIColor = .black) -> UIImage? {
        return UIImage(qrCodeString: self, size: factor, color: color)
    }
}

public extension URL {
    func qrCode(size factor: CGFloat = 3, color: UIColor = .black) -> UIImage? {
        return UIImage(qrCodeString: absoluteString, size: factor, color: color)
    }
}

#endif
