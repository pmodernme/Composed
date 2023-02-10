//
//  DisclosureChevron.swift
//  ZoeLog-iOS
//
//  Created by Zoe Van Brunt on 12/31/21.
//  Copyright © 2021 orgName. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct DisclosureChevron: View {
    public init() { }
    
    public var body: some View {
        Image(systemName: "chevron.right")
            .font(.caption.weight(.bold))
            .foregroundColor(Color(UIColor.tertiaryLabel))
            .padding(.leading, 4)
    }
}

@available(iOS 13.0, *)
class DisclosureChevronView: UIView {
    var insets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 8)
        
    lazy var imageView = UIImageView(image: .chevron)
        .apply {
            $0.contentMode = .right
        }
        .withTintColor(.tertiaryLabel)
        .subview(of: self)
    
    override var intrinsicContentSize: CGSize {
        return sizeThatFits(.max)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return imageView.sizeThatFits(size).expanded(by: insets)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = bounds.inset(by: insets)
    }
}

@available(iOS 13.0, *)
extension UIImage {
    static var chevron: UIImage? {
        UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(
            font: UIFontMetrics(forTextStyle: .caption1)
                .scaledFont(for: .systemFont(ofSize: 12, weight: .bold)))
        )
    }
}

@available(iOS 15.0, *)
struct DisclosureChevron_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DisclosureChevron()
            UIViewPreview {
                DisclosureChevronView()
            }
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
