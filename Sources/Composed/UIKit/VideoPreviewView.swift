//
//  QRPreviewView.swift
//  
//
//  Created by Zoe Van Brunt on 5/6/22.
//

import UIKit
import AVKit

public class VideoPreviewView: UIView {
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        guard let layer = layer as? AVCaptureVideoPreviewLayer else {
            fatalError("Expected `AVCaptureVideoPreviewLayer` type for layer. Check PreviewView.layerClass implementation.")
        }
        return layer
    }
    
    var session: AVCaptureSession? {
        get { videoPreviewLayer.session }
        set { videoPreviewLayer.session = newValue }
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        switch UIDevice.current.orientation {
            case .portrait: videoPreviewLayer.connection?.videoOrientation = .portrait
            case .landscapeLeft: videoPreviewLayer.connection?.videoOrientation = .landscapeRight
            case .landscapeRight: videoPreviewLayer.connection?.videoOrientation = .landscapeLeft
            case .portraitUpsideDown: videoPreviewLayer.connection?.videoOrientation = .portraitUpsideDown
            default: videoPreviewLayer.connection?.videoOrientation = .portrait
        }
    }
    
    public override class var layerClass: AnyClass {
        AVCaptureVideoPreviewLayer.self
    }
    
}
