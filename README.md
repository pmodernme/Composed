#  Composed

---

**Make designing views in `layoutSubviews()` simpler with extensions to `CGGeometry` structs such as `CGRect`, `CGSize`, and `CGPoint`.**

Composed is in its early stages of development. Thanks for your interest!

## Features

- [x] Create `CGRect` from `CGSize` by pinning to a `CGPoint`
- [x] Supports pinning by origin, center, and any corner
- [x] Easily access `CGRect` corners by value instead of deriving them
- [x] Adds convenience functions and variables such as `center` to `CGRect` and `offset(by:)` to `CGPoint`

## Usage

The core concept of layout using **Composed** is making manual layout easier to read.

*Using Composed*
```swift
boxView.frame = CGSize(width: 200, height: 125)
    .setCenter(bounds.center)
```

*Using CGGeometry*
```swift
let greenSize = CGSize(width: 200, height: 125)
boxView.frame = CGRect(
    x: bounds.midX - greenSize.width/2,
    y: bounds.midY - greenSize.height/2,
    width: greenSize.width,
    height: greenSize.height
)
```

You can chain functions referencing another `CGRect`'s geometry.

*Using Composed*
```swift
topLabel.frame = topLabel.sizeThatFits(bounds.size)
    .setCorner(
        .bottomLeft(
            boxView.frame.corners.topLeft.point
                .offset(by: CGPoint(x: 0, y: -4))
        )
)
```

*Using CGGeometry*
```swift
let greenLabelSize = topLabel.sizeThatFits(bounds.size)
topLabel.frame = CGRect(
    x: boxView.frame.minX,
    y: boxView.frame.minY - (greenLabelSize.height + 4),
    width: greenLabelSize.width,
    height: greenLabelSize.height
)
```

![](img/relational.png)

## Author

Zoe Van Brunt, <a href="http://www.zvb.io">zvb.io</a>
