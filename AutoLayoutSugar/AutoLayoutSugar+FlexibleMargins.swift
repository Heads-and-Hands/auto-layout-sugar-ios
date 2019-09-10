//
// Created by Handh on 2019-09-10.
// Copyright (c) 2019 Heads and hands. All rights reserved.
//

import UIKit

public struct FlexibleMargin {
    var points: CGFloat!
    var relation: NSLayoutConstraint.Relation!
}

prefix operator >=
@discardableResult
public prefix func >= (points: CGFloat) -> FlexibleMargin {
    return FlexibleMargin(points: points, relation: .greaterThanOrEqual)
}

prefix operator <=
@discardableResult
public prefix func <= (points: CGFloat) -> FlexibleMargin {
    return FlexibleMargin(points: points, relation: .lessThanOrEqual)
}
