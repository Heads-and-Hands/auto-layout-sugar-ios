//
//  AutoLayoutSugar+Sizes.swift
//  AutoLayoutSugar
//
//  Created by Handh on 19/08/2019.
//  Copyright © 2019 Heads and hands. All rights reserved.
//

import UIKit

/// Current view sizes modifiers
public extension UIView {

    /// Update current view size constraints with new value
    ///
    /// - Parameters:
    ///   - value:          CGSize value of new size
    ///
    /// - Returns: Current view.
    @discardableResult
    func size(_ value: CGSize) -> Self {
        heightAnchor ~ value.height
        widthAnchor ~ value.width
        return self
    }
    /// Update current view height constraint with new value
    ///
    /// - Parameters:
    ///   - value:          CGFloat value of new height
    ///
    /// - Returns: Current view.
    @discardableResult
    func height(_ value: CGFloat = 0.0) -> Self {
        heightAnchor ~ value
        return self
    }

    /// Assign current view height to related view's height
    ///
    /// - Parameters:
    ///   - relatedView:    Related view
    ///
    /// - Returns: Current view.
    @discardableResult
    func height(as relatedView: UIView) -> Self {
        heightAnchor ~ relatedView.heightAnchor
        return self
    }

    /// Install current view height anchor to height anchor of related view with inset.
    ///
    /// - Parameters:
    ///   - flexibleMargin: Less/greater than related view left side with points offset (like .bottom(<=90))
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///
    /// - Returns: Current view.
    @discardableResult
    func height(_ flexibleMargin: FlexibleMargin, as relatedView: UIView? = nil) -> Self {
        guard let relation = flexibleMargin.relation else {
            return self
        }
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        switch relation {
        case .greaterThanOrEqual:
            heightAnchor >~ relatedView.heightAnchor + (flexibleMargin.points ?? 0)
        case .lessThanOrEqual:
            heightAnchor <~ relatedView.heightAnchor + (flexibleMargin.points ?? 0)
        default:
            break
        }

        return self
    }

    /// Update current view width constraint with new value
    ///
    /// - Parameters:
    ///   - value:          CGFloat value of new height
    ///
    /// - Returns: Current view.
    @discardableResult
    func width(_ value: CGFloat = 0.0) -> Self {
        widthAnchor ~ value
        return self
    }

    /// Assign current view width to related view's width
    ///
    /// - Parameters:
    ///   - relatedView:    Related view
    ///
    /// - Returns: Current view.
    @discardableResult
    func width(as relatedView: UIView) -> Self {
        widthAnchor ~ relatedView.widthAnchor
        return self
    }

    /// Install current view width anchor to width anchor of related view with inset.
    ///
    /// - Parameters:
    ///   - flexibleMargin: Less/greater than related view left side with points offset (like .bottom(<=90))
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///
    /// - Returns: Current view.
    @discardableResult
    func width(_ flexibleMargin: FlexibleMargin, as relatedView: UIView? = nil) -> Self {
        guard let relation = flexibleMargin.relation else {
            return self
        }
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        switch relation {
        case .greaterThanOrEqual:
            widthAnchor >~ relatedView.widthAnchor + (flexibleMargin.points ?? 0)
        case .lessThanOrEqual:
            widthAnchor <~ relatedView.widthAnchor + (flexibleMargin.points ?? 0)
        default:
            break
        }

        return self
    }

}
