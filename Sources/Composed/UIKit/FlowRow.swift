//
//  FlowRow.swift
//  ZVBUIUtilities
//
//  Created by Zoe Van Brunt on 6/22/21.
//  Copyright © 2021 Zoe Van Brunt. All rights reserved.
//

#if canImport(UIKit)

import UIKit

public class FlowRow: UIView {
    
    public var insets = UIEdgeInsets.zero { didSet { setNeedsLayout() }}
    
    public var spacing = CGSize.zero { didSet { setNeedsLayout() }}
    
    public override func tintColorDidChange() {
        super.tintColorDidChange()
        subviews.forEach { $0.tintColor = tintColor }
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        let insetSize = size.inset(by: insets)
        
        var result = CGSize.zero
        
        var workingRow = CGSize.zero
        
        var rows = 0
        
        for view in subviews {
            let viewSize = view.sizeThatFits(insetSize)
            
            if workingRow.width > 0, workingRow.width + spacing.width + viewSize.width > insetSize.width {
                result = result.stackVertically(workingRow)
                workingRow = .zero
                workingRow.width -= spacing.width
                rows += 1
            }
            
            workingRow = workingRow.stackHorizontally(viewSize)
            workingRow.width += spacing.width
        }
        
        result = result.stackVertically(workingRow)
        
        result.height += spacing.height * CGFloat(rows)
        
        return result.expanded(by: insets)
    }
    
    public override func layoutSubviews() {
        let insetBounds = bounds.inset(by: insets)
        
        var x: CGFloat = insetBounds.minX
        var y: CGFloat = insetBounds.minY
        var rowHeight: CGFloat = 0
        
        for view in subviews {
            let viewSize = view.sizeThatFits(insetBounds.size)
            
            if x > insetBounds.minX, x + viewSize.width > insetBounds.width {
                y += rowHeight + spacing.height
                x = insetBounds.minX
                rowHeight = 0
            }
            
            view.frame = viewSize.setOrigin(x: x, y: y)
            x += viewSize.width + spacing.width
            rowHeight = max(rowHeight, viewSize.height)
        }
    }    
}

#endif
