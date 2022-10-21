//
//  QRView.swift
//  
//
//  Created by Zoe Van Brunt on 4/14/22.
//

#if canImport(SwiftUI)

import SwiftUI

@available(iOS 13.0, *)
public struct QRView: View {
    
    public init(string: String, scale: CGFloat = 1) {
        self.string = string
        self.scale = scale
    }
    
    var string: String
    
    var scale: CGFloat
    
    var image: UIImage? {
        UIImage(qrCodeString: string, scale: scale, foregroundColor: .black, backgroundColor: .clear)
    }
    
    public var body: some View {
        if let image = image {
            Image(uiImage: image)
                .renderingMode(.template)
                .resizable()
                .interpolation(.none)
                .aspectRatio(contentMode: .fit)
        } else {
            EmptyView()
        }
    }
    
}

#if DEBUG

@available(iOS 15.0, *)
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            let string = "Testing 1, 2, 3"
            
            QRView(string: string, scale: 4)
                .foregroundColor(.secondary)
//                .background { Color.white.opacity(0.8) }
                .padding()
            Text(string)
                .font(.caption)
        }
        .padding()
        .background {
            Color.green
                .edgesIgnoringSafeArea(.all)
        }
        .previewLayout(.sizeThatFits)
    }
}
#endif
#endif
