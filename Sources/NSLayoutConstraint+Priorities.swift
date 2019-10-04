//
// Created by Handh on 2019-09-10.
// Copyright (c) 2019 Heads and hands. All rights reserved.
//

import UIKit

prefix operator >~
@discardableResult
public prefix func >~ (constraint: NSLayoutConstraint) -> UILayoutPriority {
    let priority = constraint.priority.rawValue + 1
    return UILayoutPriority(rawValue: priority)
}

prefix operator <~
@discardableResult
public prefix func <~ (constraint: NSLayoutConstraint) -> UILayoutPriority {
    let priority = constraint.priority.rawValue - 1
    return UILayoutPriority(rawValue: priority)
}

public extension NSLayoutConstraint {

    /// Set constraint priority with raw value
    ///
    /// - Parameters:
    ///   - rawValue:   CGFloat priority value
    ///
    /// - Returns: Current view.
    @discardableResult
    func priority(_ priorityRaw: Float) -> Self {
        self.priority = UILayoutPriority(rawValue: priorityRaw)
        return self
    }

    /// Set constraint priority
    ///
    /// - Parameters:
    ///   - priority:   UILayoutPriority priority value
    ///
    /// - Returns: Current view.
    @discardableResult
    func priority(_ priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }

}
