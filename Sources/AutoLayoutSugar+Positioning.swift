//
//  AutoLayoutSugar+Positioning.swift
//  AutoLayoutSugar
//
//  Created by Handh on 19/08/2019.
//  Copyright © 2019 Heads and hands. All rights reserved.
//

import UIKit

/// Current view position modifiers
public extension UIView {

    /// Install current view centerYAnchor to centerYAnchor of related view with inset.
    ///
    /// - Parameters:
    ///   - inset:          Inset from related view center Y (positive)
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///   - priority:       UILayoutPriority value for new constraint, by default UILayoutPriority.required
    ///
    /// - Returns: Current view.
    @discardableResult
    func centerY(_ inset: CGFloat = 0.0, to relatedView: UIView? = nil, priority: UILayoutPriority = .required) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        guidedCenterYAnchor.constraint(equalTo: relatedView.guidedCenterYAnchor, constant: inset).priority(priority).activate()
        return self
    }

    /// Install current view centerXAnchor to centerXAnchor of related view with inset.
    ///
    /// - Parameters:
    ///   - inset:          Inset from related view center X (positive)
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///   - priority:       UILayoutPriority value for new constraint, by default UILayoutPriority.required
    ///
    /// - Returns: Current view.
    @discardableResult
    func centerX(_ inset: CGFloat = 0.0, to relatedView: UIView? = nil, priority: UILayoutPriority = .required) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        guidedCenterXAnchor.constraint(equalTo: relatedView.guidedCenterXAnchor, constant: inset).priority(priority).activate()
        return self
    }

    /// Install current view centerXAnchor and centerYAnchor to center of related view with insets.
    ///
    /// - Parameters:
    ///   - x:              X inset from related view center (positive)
    ///   - y:              Y inset from related view center (positive)
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///   - priority:       UILayoutPriority value for new constraint, by default UILayoutPriority.required
    ///
    /// - Returns: Current view.
    @discardableResult
    func center(x xInset: CGFloat = 0.0, y yInset: CGFloat = 0.0, to relatedView: UIView? = nil) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        guidedCenterXAnchor ~ relatedView.guidedCenterXAnchor + xInset
        guidedCenterYAnchor ~ relatedView.guidedCenterYAnchor + yInset
        return self
    }

    /// Install current view leading anchor to leading anchor of related view with inset.
    ///
    /// - Parameters:
    ///   - inset:          Inset from related view leading anchor (positive)
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///   - priority:       UILayoutPriority value for new constraint, by default UILayoutPriority.required
    ///
    /// - Returns: Current view.
    @discardableResult
    func left(_ inset: CGFloat = 0.0, to relatedView: UIView? = nil, priority: UILayoutPriority = .required) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        guidedLeadingAnchor.constraint(equalTo: relatedView.guidedLeadingAnchor, constant: inset).priority(priority).activate()
        return self
    }

    /// Install current view leading anchor to leading anchor of related view with inset.
    ///
    /// - Parameters:
    ///   - flexibleMargin: Less/greater than related view left side with points offset (like .left(<=90))
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///   - priority:       UILayoutPriority value for new constraint, by default UILayoutPriority.required
    ///
    /// - Returns: Current view.
    @discardableResult
    func left(_ flexibleMargin: FlexibleMargin, to relatedView: UIView? = nil, priority: UILayoutPriority = .required) -> Self {
        guard let relation = flexibleMargin.relation else {
            return self
        }
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        switch relation {
        case .greaterThanOrEqual:
            guidedLeadingAnchor.constraint(
                    greaterThanOrEqualTo: relatedView.guidedLeadingAnchor,
                    constant: flexibleMargin.points ?? 0
            )
                    .priority(priority)
                    .activate()
        case .lessThanOrEqual:
            guidedLeadingAnchor.constraint(
                            lessThanOrEqualTo: relatedView.guidedLeadingAnchor,
                            constant: flexibleMargin.points ?? 0
                    )
                    .priority(priority)
                    .activate()
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
    ///   - priority:       UILayoutPriority value for new constraint, by default UILayoutPriority.required
    ///
    /// - Returns: Current view.
    @discardableResult
    func left(to side: LayoutPinnedSide, of relatedView: UIView? = nil, priority: UILayoutPriority = .required) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        guidedLeadingAnchor.constraint(equalTo: relatedView.anchorX(for: side), constant: side.offset).priority(priority).activate()
        return self
    }

    /// Install current view leading anchor to current side's xAnchor of related view.
    ///
    /// - Parameters:
    ///   - side:           Concrete side of related view that controls current view leading anchor.
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///   - priority:       UILayoutPriority value for new constraint, by default UILayoutPriority.required
    ///
    /// - Returns: Current view.
    @discardableResult
    func left(to side: LayoutSideDirection, of relatedView: UIView? = nil, priority: UILayoutPriority = .required) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        guidedLeadingAnchor.constraint(equalTo: relatedView.anchorX(for: side)).priority(priority).activate()
        return self
    }

    /// Install current view trailing anchor to trailing anchor of related view with inset.
    ///
    /// - Parameters:
    ///   - inset:          Inset from related view trailing anchor (negative)
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///   - priority:       UILayoutPriority value for new constraint, by default UILayoutPriority.required
    ///
    /// - Returns: Current view.
    @discardableResult
    func right(_ inset: CGFloat = 0.0, to relatedView: UIView? = nil, priority: UILayoutPriority = .required) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        guidedTrailingAnchor.constraint(equalTo: relatedView.guidedTrailingAnchor, constant: -inset).priority(priority).activate()
        return self
    }

    /// Install current view trailing anchor to trailing anchor of related view with inset.
    ///
    /// - Parameters:
    ///   - flexibleMargin: Less/greater than related view right side with points offset (like .right(<=90))
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///   - priority:       UILayoutPriority value for new constraint, by default UILayoutPriority.required
    ///
    /// - Returns: Current view.
    @discardableResult
    func right(_ flexibleMargin: FlexibleMargin, to relatedView: UIView? = nil, priority: UILayoutPriority = .required) -> Self {
        guard let relation = flexibleMargin.relation else {
            return self
        }
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        switch relation {
        case .greaterThanOrEqual:
            guidedTrailingAnchor.constraint(
                            greaterThanOrEqualTo: relatedView.guidedTrailingAnchor,
                            constant: flexibleMargin.points ?? 0
                    )
                    .priority(priority)
                    .activate()
        case .lessThanOrEqual:
            guidedTrailingAnchor.constraint(
                            lessThanOrEqualTo: relatedView.guidedTrailingAnchor,
                            constant: flexibleMargin.points ?? 0
                    )
                    .priority(priority)
                    .activate()
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
    ///   - priority:       UILayoutPriority value for new constraint, by default UILayoutPriority.required
    ///
    /// - Returns: Current view.
    @discardableResult
    func right(to side: LayoutPinnedSide, of relatedView: UIView? = nil, priority: UILayoutPriority = .required) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        guidedTrailingAnchor.constraint(equalTo: relatedView.anchorX(for: side), constant: -side.offset).priority(priority).activate()
        return self
    }

    /// Install current view trailing anchor to current side's xAnchor of related view.
    ///
    /// - Parameters:
    ///   - side:           Concrete side of related view that controls current view trailing anchor.
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///   - priority:       UILayoutPriority value for new constraint, by default UILayoutPriority.required
    ///
    /// - Returns: Current view.
    @discardableResult
    func right(to side: LayoutSideDirection, of relatedView: UIView? = nil, priority: UILayoutPriority = .required) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        guidedTrailingAnchor.constraint(equalTo: relatedView.anchorX(for: side)).priority(priority).activate()
        return self
    }

    /// Install current view top anchor to top anchor of related view with inset.
    ///
    /// - Parameters:
    ///   - inset:          Inset from related view top anchor (positive)
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///   - priority:       UILayoutPriority value for new constraint, by default UILayoutPriority.required
    ///
    /// - Returns: Current view.
    @discardableResult
    func top(_ inset: CGFloat = 0.0, to relatedView: UIView? = nil, priority: UILayoutPriority = .required) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        guidedTopAnchor.constraint(equalTo: relatedView.guidedTopAnchor, constant: inset).priority(priority).activate()
        return self
    }

    /// Install current view top anchor to top anchor of related view with inset.
    ///
    /// - Parameters:
    ///   - flexibleMargin: Less/greater than related view top side with points offset (like .top(<=90))
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///   - priority:       UILayoutPriority value for new constraint, by default UILayoutPriority.required
    ///
    /// - Returns: Current view.
    @discardableResult
    func top(_ flexibleMargin: FlexibleMargin, to relatedView: UIView? = nil, priority: UILayoutPriority = .required) -> Self {
        guard let relation = flexibleMargin.relation else {
            return self
        }
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        switch relation {
        case .greaterThanOrEqual:
            guidedTopAnchor.constraint(
                            greaterThanOrEqualTo: relatedView.guidedTopAnchor,
                            constant: flexibleMargin.points ?? 0
                    )
                    .priority(priority)
                    .activate()
        case .lessThanOrEqual:
            guidedTopAnchor.constraint(
                            lessThanOrEqualTo: relatedView.guidedTopAnchor,
                            constant: flexibleMargin.points ?? 0
                    )
                    .priority(priority)
                    .activate()
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
    ///   - priority:       UILayoutPriority value for new constraint, by default UILayoutPriority.required
    ///
    /// - Returns: Current view.
    @discardableResult
    func top(to side: LayoutPinnedSide, of relatedView: UIView? = nil, priority: UILayoutPriority = .required) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        guidedTopAnchor.constraint(equalTo: relatedView.anchorY(for: side), constant: side.offset).priority(priority).activate()
        return self
    }

    /// Install current view top anchor to current side's yAnchor of related view.
    ///
    /// - Parameters:
    ///   - side:           Concrete side of related view that controls current view top anchor.
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///   - priority:       UILayoutPriority value for new constraint, by default UILayoutPriority.required
    ///
    /// - Returns: Current view.
    @discardableResult
    func top(to side: LayoutSideDirection, of relatedView: UIView? = nil, priority: UILayoutPriority = .required) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        guidedTopAnchor.constraint(equalTo: relatedView.anchorY(for: side)).priority(priority).activate()
        return self
    }

    /// Install current view bottom anchor to bottom anchor of related view with inset.
    ///
    /// - Parameters:
    ///   - inset:          Inset from related view bottom anchor (negative)
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///   - priority:       UILayoutPriority value for new constraint, by default UILayoutPriority.required
    ///
    /// - Returns: Current view.
    @discardableResult
    func bottom(_ inset: CGFloat = 0.0, to relatedView: UIView? = nil, priority: UILayoutPriority = .required) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        guidedBottomAnchor.constraint(equalTo: relatedView.guidedBottomAnchor, constant: -inset).priority(priority).activate()
        return self
    }

    /// Install current view bottom anchor to bottom anchor of related view with inset.
    ///
    /// - Parameters:
    ///   - flexibleMargin: Less/greater than related view bottom side with points offset (like .bottom(<=90))
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///   - priority:       UILayoutPriority value for new constraint, by default UILayoutPriority.required
    ///
    /// - Returns: Current view.
    @discardableResult
    func bottom(_ flexibleMargin: FlexibleMargin, to relatedView: UIView? = nil, priority: UILayoutPriority = .required) -> Self {
        guard let relation = flexibleMargin.relation else {
            return self
        }
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        switch relation {
        case .greaterThanOrEqual:
            guidedBottomAnchor.constraint(
                            greaterThanOrEqualTo: relatedView.guidedBottomAnchor,
                            constant: flexibleMargin.points ?? 0
                    )
                    .priority(priority)
                    .activate()
        case .lessThanOrEqual:
            guidedBottomAnchor.constraint(
                            lessThanOrEqualTo: relatedView.guidedBottomAnchor,
                            constant: flexibleMargin.points ?? 0
                    )
                    .priority(priority)
                    .activate()
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
    ///   - priority:       UILayoutPriority value for new constraint, by default UILayoutPriority.required
    ///
    /// - Returns: Current view.
    @discardableResult
    func bottom(to side: LayoutPinnedSide, of relatedView: UIView? = nil, priority: UILayoutPriority = .required) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        guidedBottomAnchor.constraint(equalTo: relatedView.anchorY(for: side), constant: -side.offset).priority(priority).activate()
        return self
    }


    /// Install current view bottom anchor to current side's yAnchor of related view.
    ///
    /// - Parameters:
    ///   - side:           Concrete side of related view that controls current view bottom anchor.
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///   - priority:       UILayoutPriority value for new constraint, by default UILayoutPriority.required
    ///
    /// - Returns: Current view.
    @discardableResult
    func bottom(to side: LayoutSideDirection, of relatedView: UIView? = nil, priority: UILayoutPriority = .required) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        guidedBottomAnchor.constraint(equalTo: relatedView.anchorY(for: side)).priority(priority).activate()
        return self
    }
}
