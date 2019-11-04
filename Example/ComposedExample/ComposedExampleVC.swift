//
//  ViewController.swift
//  ComposedExample
//
//  Created by Zoe Van Brunt on 11/3/19.
//  Copyright © 2019 Zoe Van Brunt. All rights reserved.
//

import UIKit
import Composed

class ComposedExampleVC: UIViewController {
    override func loadView() {
        self.view = ComposedExampleView()
    }
}

class ComposedExampleView: UIView {
    lazy var boxView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        addSubview(view)
        return view
    }()
    
    lazy var topLabel: UIView = {
        let l = UILabel()
        l.text = "Composed"
        l.font = .preferredFont(forTextStyle: .title1)
        l.textColor = .systemGreen
        addSubview(l)
        return l
    }()
    
    lazy var bottomLabel: UIView = {
        let l = UILabel()
        l.text = "So Easy!"
        l.font = .preferredFont(forTextStyle: .title2)
        l.textColor = .systemBackground
        addSubview(l)
        return l
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        boxView.frame = CGSize(width: 200, height: 125)
            .setCenter(bounds.center)
        
        topLabel.frame = topLabel.sizeThatFits(bounds.size)
            .setCorner(
                .bottomLeft(
                    boxView.frame.corners.topLeft.point
                        .offset(by: CGPoint(x: 0, y: -4))
                )
        )
        
//        bottomLabel.frame = bottomLabel.sizeThatFits(bounds.size)
//            .setCorner(
//                .bottomRight(
//                    boxView.frame.corners.bottomRight.point
//                        .offset(by: CGPoint(x: -6, y: -4))
//                )
//        )
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct ComposedExampleVC_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return ComposedExampleVC()
        }
    }
}
#endif
