//
//  ViewController.swift
//  ComposedExample
//
//  Created by Zoe Van Brunt on 11/3/19.
//  Copyright © 2019 Zoe Van Brunt. All rights reserved.
//

import UIKit
import SwiftUI
import Composed

class ComposedExampleVC: UIViewController {
    override func loadView() {
        view = ComposedExampleView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
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
        l.numberOfLines = 0
        l.font = .preferredFont(forTextStyle: .title1)
        l.adjustsFontForContentSizeCategory = true
        l.textColor = .systemGreen
        addSubview(l)
        return l
    }()
    
    lazy var bottomLabel: UIView = {
        let l = UILabel()
        l.text = "So Easy!"
        l.numberOfLines = 0
        l.font = .preferredFont(forTextStyle: .title2)
        l.adjustsFontForContentSizeCategory = true
        l.textColor = .systemBackground
        addSubview(l)
        return l
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        boxView.frame = CGSize(width: 200, height: 125)
            .setCenter(bounds.center)
        
        topLabel.frame = topLabel
            .sizeThatFits(width: boxView.frame.width)
            .setCorner(
                .bottomLeft(
                    boxView.frame.corners.topLeft.point
                        .offsetBy(dx: 0, dy: -4)
                )
            )
        
        let insetBox = boxView.frame.insetBy(dx: 6, dy: 4)
        bottomLabel.frame = intersection(
            bottomLabel.sizeThatFits(insetBox.size),
            insetBox.size
        ).setCorner(
            .bottomRight(
                insetBox.corners.bottomRight.point
            )
        )
    }
}

struct ComposedExampleVC_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            ComposedExampleVC()
        }
    }
}
