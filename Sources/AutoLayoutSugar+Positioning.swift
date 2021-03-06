//
//  AutoLayoutSugar+Positioning.swift
//  AutoLayoutSugar
//
//  Created by Handh on 19/08/2019.
//  Copyright © 2019 Heads and hands. All rights reserved.
//

import UIKit

/// Current view position modificators
public extension UIView {

    /// Install current view centerYAnchor to centerYAnchor of related view with inset.
    ///
    /// - Parameters:
    ///   - inset:          Inset from related view center Y
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///
    /// - Returns: Current view.
    @discardableResult
    func centerY(_ inset: CGFloat = 0.0, to relatedView: UIView? = nil) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        safeCenterYAnchor ~ relatedView.safeCenterYAnchor + inset
        return self
    }

    /// Install current view centerXAnchor to centerXAnchor of related view with inset.
    ///
    /// - Parameters:
    ///   - inset:          Inset from related view center X
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///
    /// - Returns: Current view.
    @discardableResult
    func centerX(_ inset: CGFloat = 0.0, to relatedView: UIView? = nil) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        safeCenterXAnchor ~ relatedView.safeCenterXAnchor + inset
        return self
    }

    /// Install current view centerXAnchor and centerYAnchor to center of related view with insets.
    ///
    /// - Parameters:
    ///   - x:              X inset from related view center
    ///   - y:              Y inset from related view center
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///
    /// - Returns: Current view.
    @discardableResult
    func center(x xInset: CGFloat = 0.0, y yInset: CGFloat = 0.0, to relatedView: UIView? = nil) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        safeCenterXAnchor ~ relatedView.safeCenterXAnchor + xInset
        safeCenterYAnchor ~ relatedView.safeCenterYAnchor + yInset
        return self
    }

    /// Install current view leading anchor to leading anchor of related view with inset.
    ///
    /// - Parameters:
    ///   - inset:          Inset from related view leading anchor
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///
    /// - Returns: Current view.
    @discardableResult
    func left(_ inset: CGFloat = 0.0, to relatedView: UIView? = nil) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        safeLeadingAnchor ~ relatedView.safeLeadingAnchor + inset
        return self
    }

    /// Install current view leading anchor to leading anchor of related view with inset.
    ///
    /// - Parameters:
    ///   - flexibleMargin: Less/greater than related view left side with points offset (like .left(<=90))
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///
    /// - Returns: Current view.
    @discardableResult
    func left(_ flexibleMargin: FlexibleMargin, to relatedView: UIView? = nil) -> Self {
        guard let relation = flexibleMargin.relation else {
            return self
        }
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        switch relation {
        case .greaterThanOrEqual:
            safeLeadingAnchor >~ relatedView.safeLeadingAnchor + (flexibleMargin.points ?? 0)
        case .lessThanOrEqual:
            safeLeadingAnchor <~ relatedView.safeLeadingAnchor + (flexibleMargin.points ?? 0)
        default:
            break
        }

        return self
    }

    /// Install current view leading anchor to current side's xAnchor of related view.
    ///
    /// - Parameters:
    ///   - side:           Concrete side of related view that controls current view leading anchor.
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///
    /// - Returns: Current view.
    @discardableResult
    func left(to side: LayoutPinnedSide, of relatedView: UIView? = nil) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        safeLeadingAnchor ~ relatedView.anchorX(for: side) + side.offset
        return self
    }

    /// Install current view leading anchor to current side's xAnchor of related view.
    ///
    /// - Parameters:
    ///   - side:           Concrete side of related view that controls current view leading anchor.
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///
    /// - Returns: Current view.
    @discardableResult
    func left(to side: LayoutSideDirection, of relatedView: UIView? = nil) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        safeLeadingAnchor ~ relatedView.anchorX(for: side)
        return self
    }

    /// Install current view trailing anchor to trailing anchor of related view with inset.
    ///
    /// - Parameters:
    ///   - inset:          Inset from related view trailing anchor
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///
    /// - Returns: Current view.
    @discardableResult
    func right(_ inset: CGFloat = 0.0, to relatedView: UIView? = nil) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        safeTrailingAnchor ~ relatedView.safeTrailingAnchor - inset
        return self
    }

    /// Install current view trailing anchor to trailing anchor of related view with inset.
    ///
    /// - Parameters:
    ///   - flexibleMargin: Less/greater than related view left side with points offset (like .right(<=90))
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///
    /// - Returns: Current view.
    @discardableResult
    func right(_ flexibleMargin: FlexibleMargin, to relatedView: UIView? = nil) -> Self {
        guard let relation = flexibleMargin.relation else {
            return self
        }
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        switch relation {
        case .greaterThanOrEqual:
            safeTrailingAnchor >~ relatedView.safeTrailingAnchor + (flexibleMargin.points ?? 0)
        case .lessThanOrEqual:
            safeTrailingAnchor <~ relatedView.safeTrailingAnchor + (flexibleMargin.points ?? 0)
        default:
            break
        }

        return self
    }

    /// Install current view trailing anchor to current side's xAnchor of related view.
    ///
    /// - Parameters:
    ///   - side:           Concrete side of related view that controls current view trailing anchor.
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///
    /// - Returns: Current view.
    @discardableResult
    func right(to side: LayoutPinnedSide, of relatedView: UIView? = nil) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        safeTrailingAnchor ~ relatedView.anchorX(for: side) - side.offset
        return self
    }

    /// Install current view trailing anchor to current side's xAnchor of related view.
    ///
    /// - Parameters:
    ///   - side:           Concrete side of related view that controls current view trailing anchor.
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///
    /// - Returns: Current view.
    @discardableResult
    func right(to side: LayoutSideDirection, of relatedView: UIView? = nil) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        safeTrailingAnchor ~ relatedView.anchorX(for: side)
        return self
    }

    /// Install current view top anchor to top anchor of related view with inset.
    ///
    /// - Parameters:
    ///   - inset:          Inset from related view trailing anchor
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///
    /// - Returns: Current view.
    @discardableResult
    func top(_ inset: CGFloat = 0.0, to relatedView: UIView? = nil) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        safeTopAnchor ~ relatedView.safeTopAnchor + inset
        return self
    }

    /// Install current view top anchor to top anchor of related view with inset.
    ///
    /// - Parameters:
    ///   - flexibleMargin: Less/greater than related view left side with points offset (like .top(<=90))
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///
    /// - Returns: Current view.
    @discardableResult
    func top(_ flexibleMargin: FlexibleMargin, to relatedView: UIView? = nil) -> Self {
        guard let relation = flexibleMargin.relation else {
            return self
        }
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        switch relation {
        case .greaterThanOrEqual:
            safeTopAnchor >~ relatedView.safeTopAnchor + (flexibleMargin.points ?? 0)
        case .lessThanOrEqual:
            safeTopAnchor <~ relatedView.safeTopAnchor + (flexibleMargin.points ?? 0)
        default:
            break
        }

        return self
    }

    /// Install current view top anchor to current side's yAnchor of related view.
    ///
    /// - Parameters:
    ///   - side:           Concrete side of related view that controls current view top anchor.
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///
    /// - Returns: Current view.
    @discardableResult
    func top(to side: LayoutPinnedSide, of relatedView: UIView? = nil) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        safeTopAnchor ~ relatedView.anchorY(for: side) + side.offset
        return self
    }

    /// Install current view top anchor to current side's yAnchor of related view.
    ///
    /// - Parameters:
    ///   - side:           Concrete side of related view that controls current view top anchor.
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///
    /// - Returns: Current view.
    @discardableResult
    func top(to side: LayoutSideDirection, of relatedView: UIView? = nil) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        safeTopAnchor ~ relatedView.anchorY(for: side)
        return self
    }

    /// Install current view bottom anchor to top anchor of related view with inset.
    ///
    /// - Parameters:
    ///   - inset:          Inset from related view bottom anchor
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///
    /// - Returns: Current view.
    @discardableResult
    func bottom(_ inset: CGFloat = 0.0, to relatedView: UIView? = nil) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        safeBottomAnchor ~ relatedView.safeBottomAnchor - inset
        return self
    }

    /// Install current view bottom anchor to bottom anchor of related view with inset.
    ///
    /// - Parameters:
    ///   - flexibleMargin: Less/greater than related view left side with points offset (like .bottom(<=90))
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///
    /// - Returns: Current view.
    @discardableResult
    func bottom(_ flexibleMargin: FlexibleMargin, to relatedView: UIView? = nil) -> Self {
        guard let relation = flexibleMargin.relation else {
            return self
        }
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        switch relation {
        case .greaterThanOrEqual:
            safeBottomAnchor >~ relatedView.safeBottomAnchor + (flexibleMargin.points ?? 0)
        case .lessThanOrEqual:
            safeBottomAnchor <~ relatedView.safeBottomAnchor + (flexibleMargin.points ?? 0)
        default:
            break
        }

        return self
    }

    /// Install current view bottom anchor to current side's yAnchor of related view.
    ///
    /// - Parameters:
    ///   - side:           Concrete side of related view that controls current view bottom anchor.
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///
    /// - Returns: Current view.
    @discardableResult
    func bottom(to side: LayoutPinnedSide, of relatedView: UIView? = nil) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        safeBottomAnchor ~ relatedView.anchorY(for: side) - side.offset
        return self
    }
}
