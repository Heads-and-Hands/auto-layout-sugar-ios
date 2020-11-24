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
        safeCenterYAnchor.constraint(equalTo: relatedView.safeCenterYAnchor, constant: inset).priority(priority).activate()
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
        safeCenterXAnchor.constraint(equalTo: relatedView.safeCenterXAnchor, constant: inset).priority(priority).activate()
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
        safeCenterXAnchor ~ relatedView.safeCenterXAnchor + xInset
        safeCenterYAnchor ~ relatedView.safeCenterYAnchor + yInset
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
        safeLeadingAnchor.constraint(equalTo: relatedView.safeLeadingAnchor, constant: inset).priority(priority).activate()
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
            safeLeadingAnchor.constraint(
                    greaterThanOrEqualTo: relatedView.safeLeadingAnchor,
                    constant: flexibleMargin.points ?? 0
            )
                    .priority(priority)
                    .activate()
        case .lessThanOrEqual:
            safeLeadingAnchor.constraint(
                            lessThanOrEqualTo: relatedView.safeLeadingAnchor,
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
        safeLeadingAnchor.constraint(equalTo: relatedView.anchorX(for: side), constant: side.offset).priority(priority).activate()
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
        safeLeadingAnchor.constraint(equalTo: relatedView.anchorX(for: side)).priority(priority).activate()
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
        safeTrailingAnchor.constraint(equalTo: relatedView.safeTrailingAnchor, constant: -inset).priority(priority).activate()
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
            safeTrailingAnchor.constraint(
                            greaterThanOrEqualTo: relatedView.safeTrailingAnchor,
                            constant: flexibleMargin.points ?? 0
                    )
                    .priority(priority)
                    .activate()
        case .lessThanOrEqual:
            safeTrailingAnchor.constraint(
                            lessThanOrEqualTo: relatedView.safeTrailingAnchor,
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
        safeTrailingAnchor.constraint(equalTo: relatedView.anchorX(for: side), constant: -side.offset).priority(priority).activate()
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
        safeTrailingAnchor.constraint(equalTo: relatedView.anchorX(for: side)).priority(priority).activate()
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
        safeTopAnchor.constraint(equalTo: relatedView.safeTopAnchor, constant: inset).priority(priority).activate()
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
            safeTopAnchor.constraint(
                            greaterThanOrEqualTo: relatedView.safeTopAnchor,
                            constant: flexibleMargin.points ?? 0
                    )
                    .priority(priority)
                    .activate()
        case .lessThanOrEqual:
            safeTopAnchor.constraint(
                            lessThanOrEqualTo: relatedView.safeTopAnchor,
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
        safeTopAnchor.constraint(equalTo: relatedView.anchorY(for: side), constant: side.offset).priority(priority).activate()
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
        safeTopAnchor.constraint(equalTo: relatedView.anchorY(for: side)).priority(priority).activate()
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
        safeBottomAnchor.constraint(equalTo: relatedView.safeBottomAnchor, constant: -inset).priority(priority).activate()
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
            safeBottomAnchor.constraint(
                            greaterThanOrEqualTo: relatedView.safeBottomAnchor,
                            constant: flexibleMargin.points ?? 0
                    )
                    .priority(priority)
                    .activate()
        case .lessThanOrEqual:
            safeBottomAnchor.constraint(
                            lessThanOrEqualTo: relatedView.safeBottomAnchor,
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
        safeBottomAnchor.constraint(equalTo: relatedView.anchorY(for: side), constant: -side.offset).priority(priority).activate()
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
        safeBottomAnchor.constraint(equalTo: relatedView.anchorY(for: side)).priority(priority).activate()
        return self
    }
}
