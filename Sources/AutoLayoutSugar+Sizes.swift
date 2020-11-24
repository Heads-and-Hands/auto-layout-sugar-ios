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
    ///   - priority:       UILayoutPriority value for new constraint, by default UILayoutPriority.required
    ///
    /// - Returns: Current view.
    @discardableResult
    func height(_ value: CGFloat = 0.0, priority: UILayoutPriority? = nil) -> Self {
        let constraint = heightAnchor.constraint(equalToConstant: value)
        if let priority = priority {
            constraint.priority(priority)
        }
        constraint.activate()
        return self
    }

    /// Assign current view height to related view's height
    ///
    /// - Parameters:
    ///   - relatedView:    Related view
    ///   - priority:       UILayoutPriority value for new constraint, by default UILayoutPriority.required
    ///
    /// - Returns: Current view.
    @discardableResult
    func height(as relatedView: UIView? = nil, priority: UILayoutPriority? = nil) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        let constraint = heightAnchor.constraint(equalTo: relatedView.heightAnchor)
        if let priority = priority {
            constraint.priority(priority)
        }
        constraint.activate()
        return self
    }

    /// Install current view height anchor to height anchor of related view with inset.
    ///
    /// - Parameters:
    ///   - flexibleMargin: Less/greater than related view height with points offset (like .bottom(<=90))
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///   - priority:       UILayoutPriority value for new constraint, by default UILayoutPriority.required
    ///
    /// - Returns: Current view.
    @discardableResult
    func height(_ flexibleMargin: FlexibleMargin, as relatedView: UIView? = nil, priority: UILayoutPriority? = nil) -> Self {
        guard let relation = flexibleMargin.relation else {
            return self
        }
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        let constraint: NSLayoutConstraint
        switch relation {
        case .greaterThanOrEqual:
            constraint = heightAnchor
                    .constraint(greaterThanOrEqualTo: relatedView.heightAnchor, constant: flexibleMargin.points ?? 0)
        case .lessThanOrEqual:
            constraint = heightAnchor
                    .constraint(lessThanOrEqualTo: relatedView.heightAnchor, constant: flexibleMargin.points ?? 0)
        default:
            return self
        }
        if let priority = priority {
            constraint.priority(priority)
        }
        constraint.activate()
        return self
    }

    /// Update current view width constraint with new value
    ///
    /// - Parameters:
    ///   - value:          CGFloat value of new width
    ///   - priority:       UILayoutPriority value for new constraint, by default UILayoutPriority.required
    ///
    /// - Returns: Current view.
    @discardableResult
    func width(_ value: CGFloat = 0.0, priority: UILayoutPriority? = nil) -> Self {
        let constraint = widthAnchor.constraint(equalToConstant: value)
        if let priority = priority {
            constraint.priority(priority)
        }
        constraint.activate()
        return self
    }

    /// Assign current view width to related view's width
    ///
    /// - Parameters:
    ///   - relatedView:    Related view
    ///   - priority:       UILayoutPriority value for new constraint, by default UILayoutPriority.required
    ///
    /// - Returns: Current view.
    @discardableResult
    func width(as relatedView: UIView? = nil, priority: UILayoutPriority? = nil) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        let constraint = widthAnchor.constraint(equalTo: relatedView.widthAnchor)
        if let priority = priority {
            constraint.priority(priority)
        }
        constraint.activate()
        return self
    }

    /// Install current view width anchor to related view flexible margin.
    ///
    /// - Parameters:
    ///   - flexibleMargin: Less/greater than related view width with points offset (like .bottom(<=90))
    ///   - relatedView:    Related view that constraints used as base, `nil` by default (if `nil` then use current view's superview as related view).
    ///   - priority:       UILayoutPriority value for new constraint, by default UILayoutPriority.required
    ///
    /// - Returns: Current view.
    @discardableResult
    func width(_ flexibleMargin: FlexibleMargin, as relatedView: UIView? = nil, priority: UILayoutPriority? = nil) -> Self {
        guard let relation = flexibleMargin.relation else {
            return self
        }
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        let constraint: NSLayoutConstraint
        switch relation {
        case .greaterThanOrEqual:
            constraint = widthAnchor
                    .constraint(greaterThanOrEqualTo: relatedView.widthAnchor, constant: flexibleMargin.points ?? 0)
        case .lessThanOrEqual:
            constraint = widthAnchor
                    .constraint(lessThanOrEqualTo: relatedView.widthAnchor, constant: flexibleMargin.points ?? 0)
        default:
            return self
        }
        if let priority = priority {
            constraint.priority(priority)
        }
        constraint.activate()
        return self
    }

}
