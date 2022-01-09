//
//  CGGeomertyExampleVC.swift
//  ComposedExample
//
//  Created by Zoe Van Brunt on 1/9/22.
//

import UIKit
import SwiftUI

class CGGeometryExampleVC: UIViewController {
    override func loadView() {
        view = CGGeometryExampleView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
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
        l.numberOfLines = 0
        l.font = .preferredFont(forTextStyle: .title1)
        l.adjustsFontForContentSizeCategory = true
        l.textColor = .systemRed
        addSubview(l)
        return l
    }()
    
    lazy var bottomLabel: UIView = {
        let l = UILabel()
        l.text = "Not so easy..."
        l.numberOfLines = 0
        l.lineBreakMode = .byTruncatingTail
        l.font = .preferredFont(forTextStyle: .title2)
        l.adjustsFontForContentSizeCategory = true
        l.textColor = .systemBackground
        addSubview(l)
        return l
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let boxSize = CGSize(width: 200, height: 125)
        boxView.frame = CGRect(
            x: bounds.midX - boxSize.width/2,
            y: bounds.midY - boxSize.height/2,
            width: boxSize.width,
            height: boxSize.height
        )
        
        let topLabelSize = topLabel.sizeThatFits(
            CGSize(
                width: boxSize.width,
                height: .greatestFiniteMagnitude
            )
        )
        topLabel.frame = CGRect(
            x: boxView.frame.minX,
            y: boxView.frame.minY - (topLabelSize.height + 4),
            width: topLabelSize.width,
            height: topLabelSize.height
        )
        
        let insetBox = boxView.frame.insetBy(dx: 6, dy: 4)
        var bottomLabelSize = bottomLabel.sizeThatFits(insetBox.size)
        bottomLabelSize.height = min(bottomLabelSize.height, insetBox.height)
        bottomLabel.frame = CGRect(
            x: insetBox.maxX - bottomLabelSize.width,
            y: insetBox.maxY - bottomLabelSize.height,
            width: bottomLabelSize.width,
            height: bottomLabelSize.height
        )
    }
}

struct CGGeometryExampleVC_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            CGGeometryExampleVC()
        }
    }
}
