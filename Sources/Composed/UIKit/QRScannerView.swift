//
//  QRScannerView.swift
//  ZVBUIUtilities
//
//  Created by Zoe Van Brunt on 7/2/19.
//  Copyright © 2019 Zoe Van Brunt. All rights reserved.
//

#if canImport(UIKit) && canImport(AVFoundation)

import UIKit
import AVFoundation

@objc public protocol QRScannerDelegate: AnyObject {
    @objc optional func didFindMetadataObjects(_ objects: [AVMetadataObject])
    @objc optional func didScanQRCode(_ str: String?)
}

public class QRScannerView: UIView {
    lazy var sessionLayer: AVCaptureVideoPreviewLayer = {
        let l = AVCaptureVideoPreviewLayer()
        layer.addSublayer(l)
        l.session = self.captureSession
        l.videoGravity = .resizeAspectFill
        return l
    }()
    
    lazy var captureSession: AVCaptureSession? = {
        let session = AVCaptureSession()
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return nil }
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: captureDevice)
        } catch let error {
            print(error)
            return nil
        }
        if session.canAddInput(videoInput) { session.addInput(videoInput) } else { return nil }
        
        let metadataOutput = AVCaptureMetadataOutput()
        if session.canAddOutput(metadataOutput) {
            session.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else { return nil }
        
        session.startRunning()
        
        return session
    }()
    
    public weak var delegate: QRScannerDelegate?
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        sessionLayer.frame = self.bounds
        switch UIDevice.current.orientation {
        case .portrait: sessionLayer.connection?.videoOrientation = .portrait
        case .landscapeLeft: sessionLayer.connection?.videoOrientation = .landscapeRight
        case .landscapeRight: sessionLayer.connection?.videoOrientation = .landscapeLeft
        case .portraitUpsideDown: sessionLayer.connection?.videoOrientation = .portraitUpsideDown
        default: sessionLayer.connection?.videoOrientation = .portrait
        }
    }
}

extension QRScannerView: AVCaptureMetadataOutputObjectsDelegate {
    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        delegate?.didFindMetadataObjects?(metadataObjects)
        
        if let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
            let str = object.stringValue {
            delegate?.didScanQRCode?(str)
        }
    }
}

#endif
