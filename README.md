#  Composed

**Make designing views in `layoutSubviews()` simpler with extensions to `CoreGraphics` structs such as `CGRect`, `CGSize`, and `CGPoint`.**

## Features

- [x] Create `CGRect` from `CGSize` by pinning to a `CGPoint`
- [x] Supports pinning by origin, center, and any corner
- [x] Easily access `CGRect` corners by value instead of deriving them
- [x] Adds convenience functions and variables such as `center` to `CGRect` and `offset(by:)` to `CGPoint`

## Usage

The core concept of layout using `Composed` is making manual layout easier to read.

```swift
// Composed
boxView.frame = CGSize(width: 200, height: 125)
    .setCenter(bounds.center)
    
// CoreGraphics
let boxSize = CGSize(width: 200, height: 125)
boxView.frame = CGRect(
    x: bounds.midX - boxSize.width/2,
    y: bounds.midY - boxSize.height/2,
    width: boxSize.width,
    height: boxSize.height
)
```

You can chain functions referencing another `CGRect`'s geometry.

![](img/relational.png)

```swift
// Composed
topLabel.frame = topLabel
    .sizeThatFits(width: boxView.frame.width)
    .setCorner(
        .bottomLeft(
            boxView.frame.corners.topLeft.point
                .offsetBy(dx: 0, dy: -4)
        )
)

let insetBox = boxView.frame.insetBy(dx: 6, dy: 4)
bottomLabel.frame = bottomLabel
    .sizeThatFits(insetBox.size)
    .setCorner(
        .bottomRight(
            insetBox.corners.bottomRight.point
        )
)

// CoreGraphics
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
let bottomLabelSize = bottomLabel.sizeThatFits(insetBox.size)
bottomLabel.frame = CGRect(
    x: insetBox.maxX - bottomLabelSize.width,
    y: insetBox.maxY - bottomLabelSize.height,
    width: bottomLabelSize.width,
    height: bottomLabelSize.height
)
```

## Author

Zoe Van Brunt, <a href="http://www.zvb.io">zvb.io</a>
