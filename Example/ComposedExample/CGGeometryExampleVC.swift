//
//  CGGeometryExampleVC.swift
//  ComposedExample
//
//  Created by Zoe Van Brunt on 11/4/19.
//  Copyright © 2019 Zoe Van Brunt. All rights reserved.
//

import UIKit

class CGGeometryExampleVC: UIViewController {
    override func loadView() {
        self.view = CGGeometryExampleView()
    }
}

class CGGeometryExampleView: UIView {
    lazy var boxView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemRed
        addSubview(view)
        return view
    }()
    
    lazy var topLabel: UIView = {
        let l = UILabel()
        l.text = "CGGeometry"
        l.font = .preferredFont(forTextStyle: .title1)
        l.textColor = .systemRed
        addSubview(l)
        return l
    }()
    
    lazy var bottomLabel: UIView = {
        let l = UILabel()
        l.text = "Very messy..."
        l.font = .preferredFont(forTextStyle: .title2)
        l.textColor = .systemBackground
        addSubview(l)
        return l
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let greenSize = CGSize(width: 200, height: 125)
        boxView.frame = CGRect(
            x: bounds.midX - greenSize.width/2,
            y: bounds.midY - greenSize.height/2,
            width: greenSize.width,
            height: greenSize.height
        )
        
        let greenLabelSize = topLabel.sizeThatFits(bounds.size)
        topLabel.frame = CGRect(
            x: boxView.frame.minX,
            y: boxView.frame.minY - (greenLabelSize.height + 4),
            width: greenLabelSize.width,
            height: greenLabelSize.height
        )
        
//        let sizeLabelSize = bottomLabel.sizeThatFits(bounds.size)
//        bottomLabel.frame = CGRect(
//            x: boxView.frame.maxX - (sizeLabelSize.width + 6),
//            y: boxView.frame.maxY - (sizeLabelSize.height + 4),
//            width: sizeLabelSize.width,
//            height: sizeLabelSize.height
//        )
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct CGGeometryExampleVC_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return CGGeometryExampleVC()
        }
    }
}
#endif
