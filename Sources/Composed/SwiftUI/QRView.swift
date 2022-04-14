//
//  QRView.swift
//  
//
//  Created by Zoe Van Brunt on 4/14/22.
//

#if canImport(SwiftUI)

import SwiftUI

@available(iOS 13.0, *)
public struct QRView: UIViewRepresentable {
    
    var string: String?
    
    var scale: CGFloat = 4
    
    public init(string: String?, scale: CGFloat = 4) {
        self.string = string
        self.scale = scale
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.magnificationFilter = .nearest
        self.view = view
    }
    
    private let view: UIImageView
    
    public func makeUIView(context: Context) -> UIImageView {
        return view
    }
    
    public func updateUIView(_ uiView: UIImageView, context: Context) {
        uiView.image = string?.qrCode(scale: scale)
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }
}

#if DEBUG

@available(iOS 15.0, *)
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        QRView(string: "Testing, 1, 2, 3", scale: 10)
    }
}
#endif
#endif
