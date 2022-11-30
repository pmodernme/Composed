//
//  QRReader.swift
//  
//
//  Created by Zoe Van Brunt on 11/11/22.
//

import SwiftUI

@available(iOS 13.0, *)
public struct QRReader: UIViewRepresentable {
    public init(scanResults: Binding<Set<String>>) {
        _scanResults = scanResults
    }
    
    @Binding public var scanResults: Set<String>
    
    public func updateUIView(_ view: QRReaderView, context: Context) { }
    
    public func makeUIView(context: Context) -> QRReaderView {
        let view = QRReaderView()
        view.videoPreviewLayer.videoGravity = .resizeAspectFill
        view.start()
        view.onReaderDidReadString = {
            scanResults = $0
        }
        return view
    }
    
    public static func dismantleUIView(_ view: QRReaderView, coordinator: ()) {
        view.stop()
    }
}
