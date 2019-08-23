//
//  UIView+SafeAnchors.swift
//  AutoLayoutSugar
//
//  Created by Handh on 15/08/2019.
//  Copyright © 2019 Heads and hands. All rights reserved.
//

import UIKit

internal var isSafeAreaEnabled: Bool = false

/// Current view safe (if needed) anchors
public extension UIView {

    /// Apply constraints installing by closure with safe areas.
    ///
    /// - Parameters:
    ///   - closure:        Contains operations with constraints like `view.top(15)` that apply safe areas.
    ///                     NOTE: Using non-AutoLayoutSugar methods in this closure have no layout effect
    ///
    /// - Returns: Current view.
    @discardableResult
    func safeArea(_ closure: (UIView) -> Void) -> Self {
        isSafeAreaEnabled = true
        closure(self)
        isSafeAreaEnabled = false
        return self
    }

    ///
    /// MARK: - Safe anchors getters, returns safe area if `isSafeAreaEnabled=true` (if used in closure of `safeArea:` method)
    ///         and returns regular anchor if `isSafeAreaEnabled=false`

    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *), isSafeAreaEnabled {
            return safeAreaLayoutGuide.topAnchor
        } else {
            return topAnchor
        }
    }

    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *), isSafeAreaEnabled {
            return safeAreaLayoutGuide.bottomAnchor
        } else {
            return bottomAnchor
        }
    }

    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *), isSafeAreaEnabled {
            return safeAreaLayoutGuide.leftAnchor
        } else {
            return leftAnchor
        }
    }

    var safeLeadingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *), isSafeAreaEnabled {
            return safeAreaLayoutGuide.leadingAnchor
        } else {
            return leadingAnchor
        }
    }

    var safeTrailingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *), isSafeAreaEnabled {
            return safeAreaLayoutGuide.trailingAnchor
        } else {
            return trailingAnchor
        }
    }

    var safeCenterXAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *), isSafeAreaEnabled {
            return safeAreaLayoutGuide.centerXAnchor
        } else {
            return centerXAnchor
        }
    }

    var safeCenterYAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *), isSafeAreaEnabled {
            return safeAreaLayoutGuide.centerYAnchor
        } else {
            return centerYAnchor
        }
    }
}
