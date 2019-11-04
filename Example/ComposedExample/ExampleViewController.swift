//
//  ViewController.swift
//  ComposedExample
//
//  Created by Zoe Van Brunt on 11/3/19.
//  Copyright © 2019 Zoe Van Brunt. All rights reserved.
//

import UIKit
import Composed

class ExampleViewController: UIViewController {
    override func loadView() {
        self.view = ExampleView()
    }
}

class ExampleView: UIView {
    lazy var greenLabel: UIView = {
        let l = UILabel()
        l.text = "Green"
        l.textColor = .systemGreen
        addSubview(l)
        return l
    }()
    
    lazy var greenView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        addSubview(view)
        return view
    }()
    
    lazy var sizeLabel: UIView = {
        let l = UILabel()
        l.text = "125 x 125"
        l.textColor = .systemGreen
        addSubview(l)
        return l
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        greenView.frame = CGSize(
            width: 125,
            height: 125
        ).setCenter(bounds.center)
        
        greenLabel.frame = greenLabel
            .sizeThatFits(bounds.size)
            .setCorner(
                .bottomLeft(
                    greenView.frame.corners.topLeft.point
                )
        )
        
        sizeLabel.frame = sizeLabel
            .sizeThatFits(bounds.size)
            .setCorner(.topRight(
                    greenView.frame.corners.bottomRight.point
                )
        )
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct ExampleViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return ExampleViewController()
        }
    }
}
#endif
