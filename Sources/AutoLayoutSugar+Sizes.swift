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
    func height(_ value: CGFloat = 0.0, priority: UILayoutPriority = .required) -> Self {
        heightAnchor.constraint(equalToConstant: value).priority(priority).activate()
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
    func height(as relatedView: UIView? = nil, priority: UILayoutPriority = .required) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        heightAnchor.constraint(equalTo: relatedView.heightAnchor).priority(priority).activate()
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
    func height(_ flexibleMargin: FlexibleMargin, as relatedView: UIView? = nil, priority: UILayoutPriority = .required) -> Self {
        guard let relation = flexibleMargin.relation else {
            return self
        }
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        switch relation {
        case .greaterThanOrEqual:
            heightAnchor
                    .constraint(greaterThanOrEqualTo: relatedView.heightAnchor, constant: flexibleMargin.points ?? 0)
                    .priority(priority)
                    .activate()
        case .lessThanOrEqual:
            heightAnchor.constraint(lessThanOrEqualTo: relatedView.heightAnchor, constant: flexibleMargin.points ?? 0)
                    .priority(priority)
                    .activate()
        default:
            break
        }

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
    func width(_ value: CGFloat = 0.0, priority: UILayoutPriority = .required) -> Self {
        widthAnchor.constraint(equalToConstant: value).priority(priority).activate()
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
    func width(as relatedView: UIView? = nil, priority: UILayoutPriority = .required) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        widthAnchor.constraint(equalTo: relatedView.widthAnchor).priority(priority).activate()
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
    func width(_ flexibleMargin: FlexibleMargin, as relatedView: UIView? = nil, priority: UILayoutPriority = .required) -> Self {
        guard let relation = flexibleMargin.relation else {
            return self
        }
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        switch relation {
        case .greaterThanOrEqual:
            widthAnchor
                    .constraint(greaterThanOrEqualTo: relatedView.widthAnchor, constant: flexibleMargin.points ?? 0)
                    .priority(priority)
                    .activate()
        case .lessThanOrEqual:
            widthAnchor.constraint(lessThanOrEqualTo: relatedView.widthAnchor, constant: flexibleMargin.points ?? 0)
                    .priority(priority)
                    .activate()
        default:
            break
        }

        return self
    }

}
