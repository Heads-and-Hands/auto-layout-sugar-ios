//
//  UIView+SafeAnchors.swift
//  AutoLayoutSugar
//
//  Created by Handh on 15/08/2019.
//  Copyright © 2019 Heads and hands. All rights reserved.
//

import UIKit

public enum BaseGuides {
    case readableContent
    case layoutMargins
    case safeArea
}

/// Current view safe (if needed) anchors
public extension UIView {

    private static var _currentLayoutGuide = [String: UILayoutGuide?]()

    private var tmpAddress: String {
        String(format: "%p", unsafeBitCast(self, to: Int.self))
    }

    private var currentLayoutGuide: UILayoutGuide? {
        get {
            UIView._currentLayoutGuide[tmpAddress] ?? nil
        }
        set {
            UIView._currentLayoutGuide[tmpAddress] = newValue
        }
    }

    @available(iOS 11.0, *)
    private var isSafeAreaEnabled: Bool {
        currentLayoutGuide == safeAreaLayoutGuide
    }

    func layout(with guide: BaseGuides, _ modifier: (UIView) -> Void) -> Self {
        let layoutGuide: UILayoutGuide
        switch guide {
        case .readableContent:
            layoutGuide = readableContentGuide
        case .layoutMargins:
            layoutGuide = layoutMarginsGuide
        case .safeArea:
            layoutGuide = safeAreaLayoutGuide
        }
        currentLayoutGuide = layoutGuide
        modifier(self)
        currentLayoutGuide = nil
        return self
    }

    func layout(with guide: UILayoutGuide, _ modifier: (UIView) -> Void) -> Self {
        currentLayoutGuide = guide
        modifier(self)
        currentLayoutGuide = nil
        return self
    }

    /// Apply constraints installing by closure with safe areas.
    ///
    /// - Parameters:
    ///   - closure:        Contains operations with constraints like `view.top(15)` that apply safe areas.
    ///                     NOTE: Using non-AutoLayoutSugar methods in this closure have no layout effect
    ///
    /// - Returns: Current view.
    @discardableResult
    @available(iOS 11.0, *)
    func safeArea(_ closure: (UIView) -> Void) -> Self {
        layout(with: .safeArea, closure)
    }

    ///
    /// MARK: - [DEPRECATED} Safe anchors getters, returns safe area if `isSafeAreaEnabled=true` (if used in closure of `safeArea:` method)
    ///         and returns regular anchor if `isSafeAreaEnabled=false`

    @available(*, deprecated)
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if isSafeAreaEnabled {
            return safeAreaLayoutGuide.topAnchor
        } else {
            return topAnchor
        }
    }

    @available(*, deprecated)
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if isSafeAreaEnabled {
            return safeAreaLayoutGuide.bottomAnchor
        } else {
            return bottomAnchor
        }
    }

    @available(*, deprecated)
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if isSafeAreaEnabled {
            return safeAreaLayoutGuide.leftAnchor
        } else {
            return leftAnchor
        }
    }

    @available(*, deprecated)
    var safeLeadingAnchor: NSLayoutXAxisAnchor {
        if isSafeAreaEnabled {
            return safeAreaLayoutGuide.leadingAnchor
        } else {
            return leadingAnchor
        }
    }

    @available(*, deprecated)
    var safeTrailingAnchor: NSLayoutXAxisAnchor {
        if isSafeAreaEnabled {
            return safeAreaLayoutGuide.trailingAnchor
        } else {
            return trailingAnchor
        }
    }

    @available(*, deprecated)
    var safeCenterXAnchor: NSLayoutXAxisAnchor {
        if isSafeAreaEnabled {
            return safeAreaLayoutGuide.centerXAnchor
        } else {
            return centerXAnchor
        }
    }

    @available(*, deprecated)
    var safeCenterYAnchor: NSLayoutYAxisAnchor {
        if isSafeAreaEnabled {
            return safeAreaLayoutGuide.centerYAnchor
        } else {
            return centerYAnchor
        }
    }

    ///
    /// MARK: - Anchors getters for current layout guide
    ///         and returns regular anchor if `isSafeAreaEnabled=false`

    internal var guidedTopAnchor: NSLayoutYAxisAnchor {
        currentLayoutGuide?.topAnchor ?? topAnchor
    }

    internal var guidedBottomAnchor: NSLayoutYAxisAnchor {
        currentLayoutGuide?.bottomAnchor ?? bottomAnchor
    }

    internal var guidedLeftAnchor: NSLayoutXAxisAnchor {
        currentLayoutGuide?.leftAnchor ?? leftAnchor
    }

    internal var guidedLeadingAnchor: NSLayoutXAxisAnchor {
        currentLayoutGuide?.leadingAnchor ?? leadingAnchor
    }

    internal var guidedTrailingAnchor: NSLayoutXAxisAnchor {
        currentLayoutGuide?.trailingAnchor ?? trailingAnchor
    }

    internal var guidedCenterXAnchor: NSLayoutXAxisAnchor {
        currentLayoutGuide?.centerXAnchor ?? centerXAnchor
    }

    internal var guidedCenterYAnchor: NSLayoutYAxisAnchor {
        currentLayoutGuide?.centerYAnchor ?? centerYAnchor
    }
}
