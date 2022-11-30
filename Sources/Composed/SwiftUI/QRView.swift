//
//  QRView.swift
//  
//
//  Created by Zoe Van Brunt on 4/14/22.
//

#if canImport(SwiftUI)

import SwiftUI
import CoreImage.CIFilterBuiltins

@available(iOS 13.0, *)
public struct QRView: View {
    
    public init(string: String) {
        self.string = string
    }
    
    var string: String
    
    var image: UIImage? {
        let failureImage = UIImage(systemName: "xmark.circle") ?? UIImage()
        
        qrGenerator.message = Data(string.utf8)
        qrGenerator.correctionLevel = "L"
        
        guard let qrImage = qrGenerator.outputImage else {
            return failureImage
        }
        
        falseColor.color0 = CIColor(color: .black)
        falseColor.color1 = CIColor(color: .clear)
        falseColor.inputImage = qrImage
        
        guard let coloredImage = falseColor.outputImage,
              let cgimg = context.createCGImage(coloredImage, from: coloredImage.extent) else {
            return failureImage
        }
        
        return UIImage(cgImage: cgimg)
    }
    
    let context = CIContext()
    let qrGenerator = CIFilter.qrCodeGenerator()
    let falseColor = CIFilter.falseColor()
    
    public var body: some View {
        if let image = image {
            Image(uiImage: image)
                .renderingMode(.template)
                .resizable()
                .interpolation(.none)
                .scaledToFit()
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
            
            QRView(string: string)
//                .foregroundColor(.secondary)
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
