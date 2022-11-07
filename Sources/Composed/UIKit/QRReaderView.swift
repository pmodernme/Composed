//
//  QRReaderView.swift
//  
//
//  Created by Zoe Van Brunt on 5/6/22.
//

#if canImport(UIKit) && canImport(AVFoundation)

import AVFoundation
import UIKit

@available(iOS 10.0, *)
public class QRReaderView: VideoPreviewView {
    
    public var isCameraAuthorized: Bool { AVCaptureDevice.authorizationStatus(for: .video) == .authorized }
    public var isCameraAuthorizationDetermined: Bool { AVCaptureDevice.authorizationStatus(for: .video) != .notDetermined }
    
    public var onReaderDidReadString: ((Set<String>) -> Void)?
    
    public var maxSimultaneousReadings: Int = 8
    
    public func start() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                    if granted { self?.beginSession() }
                }
            case .authorized:
                beginSession()
            default: return
        }
    }
    
    public func stop() {
        session?.stopRunning()
    }
    
    private class MetadataObjectLayer: CAShapeLayer {
        var metadataObject: AVMetadataObject?
    }
    
    private let sessionQueue = DispatchQueue(label: "session-queue")
    private let captureOutput = AVCaptureVideoDataOutput()
    
    private var qrOverlayLayersByString = [String: MetadataObjectLayer]()
    private var layerExpirationTimerByString = [String: Timer]()
    
    private func beginSession() {
        let setup = { [weak self] in
            self?.sessionQueue.async { self?.configureSession() }
        }
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized: setup()
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    if granted { setup() }
                }
            default: return
        }
    }
    
    private func configureSession() {
        
        let session = AVCaptureSession()

        guard let captureDevice = AVCaptureDevice.default(for: .video),
              let videoInput = try? AVCaptureDeviceInput(device: captureDevice),
              session.canAddInput(videoInput) else { return }

        let metadataOutput = AVCaptureMetadataOutput()
        guard session.canAddOutput(metadataOutput) else { return }
        
        session.beginConfiguration()
        
        session.sessionPreset = .high
        
        session.addInput(videoInput)
        
        session.addOutput(metadataOutput)
        metadataOutput.metadataObjectTypes = [.qr]
        metadataOutput.setMetadataObjectsDelegate(self, queue: .main)
        
        session.commitConfiguration()

        session.startRunning()
        
        DispatchQueue.main.async { [weak self] in
            self?.session = session
        }
    }
    
}

@available(iOS 10.0, *)
extension QRReaderView: AVCaptureMetadataOutputObjectsDelegate {

    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {

        let machineObjects: [(string: String, object: AVMetadataMachineReadableCodeObject)] = metadataObjects.reduce(into: []) { partialResult, metaObj in
            guard let metaObj = videoPreviewLayer.transformedMetadataObject(for: metaObj) as? AVMetadataMachineReadableCodeObject,
                  let str = metaObj.stringValue else {
                return
            }

            partialResult.append((str, metaObj))
        }
        
        guard machineObjects.count > 0 else { return }
        
        let sliceOfMachineObjects = machineObjects[...(min(machineObjects.count, maxSimultaneousReadings) - 1)]
        
        onReaderDidReadString?(Set(sliceOfMachineObjects.map { $0.string }))
        for (string, object) in sliceOfMachineObjects {
            upsertOverlay(object, string: string)
        }
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        for layer in qrOverlayLayersByString.values where layer.superlayer == nil {
            videoPreviewLayer.addSublayer(layer)
        }
        CATransaction.commit()
    }
    
    private func upsertOverlay(_ object: AVMetadataMachineReadableCodeObject, string: String) {
        
        let layer = qrOverlayLayersByString[string] ?? {
            let layer = MetadataObjectLayer()
            layer.lineJoin = .round
            layer.lineWidth = 7.0
            layer.strokeColor = tintColor.withAlphaComponent(0.7).cgColor
            layer.fillColor = tintColor.withAlphaComponent(0.3).cgColor
            qrOverlayLayersByString[string] = layer
            return layer
        }()
        
        layer.metadataObject = object
        
        layer.path = barcodeOverlayPath(corners: object.corners)
        
        layerExpirationTimerByString[string]?.invalidate()
        layerExpirationTimerByString[string] = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] timer in
            let layer = self?.qrOverlayLayersByString.removeValue(forKey: string)
            layer?.removeFromSuperlayer()
            timer.invalidate()
            self?.layerExpirationTimerByString.removeValue(forKey: string)
        })
    }
    
    private func barcodeOverlayPath(corners: [CGPoint]) -> CGMutablePath {
        let path = CGMutablePath()
        
        if let corner = corners.first {
            path.move(to: corner, transform: .identity)
            
            for corner in corners[1..<corners.count] {
                path.addLine(to: corner)
            }
            
            path.closeSubpath()
        }
        
        return path
    }

}

#endif
