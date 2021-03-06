//
//  AutoLayoutSugar.swift
//  AutoLayoutSugar
//
//  Created by Handh on 15/08/2019.
//  Copyright © 2019 Heads and hands. All rights reserved.
//

import UIKit

/// Main UIView extension for auto layout sugar, all methods return Self to enjoy the power of chaining
public extension UIView {

    /// Prepare current view for auto layout actions, changes translatesAutoresizingMaskIntoConstraints to false.
    ///
    /// - Parameters:
    ///   none
    ///
    /// - Returns: Current view.
    @discardableResult
    func prepareForAutoLayout() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }

    /// Pin current view to superview's edges with insets.
    ///
    /// - Parameters:
    ///   - insets: Insets from superview edges, .zero by default
    ///
    /// - Returns: Current view.
    @discardableResult
    func pinToSuperview(with insets: UIEdgeInsets = .zero) -> Self {
        return pin(
            [
                .top(insets.top),
                .left(insets.left),
                .right(insets.right),
                .bottom(insets.bottom)
            ]
        )
    }

    /// Pin current view to related view edges with insets excluding one side.
    ///
    /// - Parameters:
    ///   - excluding:      One side of related view, excluded from pinning
    ///   - insets:         Insets from related view edges, .zero by default
    ///   - relatedView:    Related view that current view pins, `nil` by default (if `nil` then use current view's superview as related view).
    ///
    /// - Returns: Current view.
    @discardableResult
    func pin(excluding side: LayoutSideDirection, insets: UIEdgeInsets = .zero, to relatedView: UIView? = nil) -> Self {
        switch side {
        case .top:
            pin([.left(insets.left), .right(insets.right), .bottom(insets.bottom)], to: relatedView)
        case .left:
            pin([.top(insets.top), .right(insets.right), .bottom(insets.bottom)], to: relatedView)
        case .right:
            pin([.top(insets.top), .left(insets.left), .bottom(insets.bottom)], to: relatedView)
        case .bottom:
            pin([.top(insets.top), .left(insets.left), .right(insets.right)], to: relatedView)
        default:
            break
        }
        return self
    }

    /// Pin current view to related view sides.
    ///
    /// - Parameters:
    ///   - sides:          Pinned sides array
    ///   - relatedView:    Related view that current view pins, `nil` by default (if `nil` then use current view's superview as related view).
    ///
    /// - Returns: Current view.
    @discardableResult
    func pin(_ sides: [LayoutPinnedSide], to relatedView: UIView? = nil) -> Self {
        sides.forEach { side in
            self.pinSide(side, to: relatedView)
        }
        return self
    }

    /// Pin current view to related view sides.
    ///
    /// - Parameters:
    ///   - sides:          Pinned sides array
    ///   - relatedView:    Related view that current view pins, `nil` by default (if `nil` then use current view's superview as related view).
    ///
    /// - Returns: Current view.
    @discardableResult
    func pin(_ sides: [LayoutSideDirection], to relatedView: UIView? = nil) -> Self {
        sides.forEach { side in
            self.pinSide(side, to: relatedView)
        }
        return self
    }

    /// Pin current view to concrete side of related view without insets.
    ///
    /// - Parameters:
    ///   - side:           Pinned side
    ///   - relatedView:    Related view that current view pins, `nil` by default (if `nil` then use current view's superview as related view).
    ///
    /// - Returns: Current view.
    @discardableResult
    func pin(_ side: LayoutSideDirection, to relatedView: UIView? = nil) -> Self {
        return pinSide(side as LayoutSideProtocol, to: relatedView)
    }

    /// Pin current view to concrete side of related view with inset (side contains inset value).
    ///
    /// - Parameters:
    ///   - side:           Pinned side
    ///   - relatedView:    Related view that current view pins, `nil` by default (if `nil` then use current view's superview as related view).
    ///
    /// - Returns: Current view.
    @discardableResult
    func pin(_ side: LayoutPinnedSide, to relatedView: UIView? = nil) -> Self {
        return pinSide(side as LayoutSideProtocol, to: relatedView)
    }

    /// PRIVATE Pin current view to concrete side of related view.
    ///
    /// - Parameters:
    ///   - side:           Pinned side as LayoutSideProtocol, can be LayoutSideDirection or LayoutPinnedSide
    ///   - relatedView:    Related view that current view pins, `nil` by default (if `nil` then use current view's superview as related view).
    ///
    /// - Returns: Current view.
    @discardableResult
    private func pinSide(_ side: LayoutSideProtocol, to relatedView: UIView? = nil) -> Self {
        let relatedView = self.getRelatedViewOrParent(with: relatedView)
        var offset: CGFloat = 0

        if let layoutPinnedSide = side as? LayoutPinnedSide {
            offset = layoutPinnedSide.offset
        }

        switch side.rawValue {
        case CommonSideRawValues.top:
            safeTopAnchor ~ relatedView.safeTopAnchor + offset
        case CommonSideRawValues.left:
            safeLeadingAnchor ~ relatedView.safeLeadingAnchor + offset
        case CommonSideRawValues.hCenter:
            safeCenterXAnchor ~ relatedView.safeCenterXAnchor + offset
        case CommonSideRawValues.vCenter:
            safeCenterYAnchor ~ relatedView.safeCenterYAnchor + offset
        case CommonSideRawValues.right:
            safeTrailingAnchor ~ relatedView.safeTrailingAnchor - offset
        case CommonSideRawValues.bottom:
            safeBottomAnchor ~ relatedView.safeBottomAnchor - offset
        default:
            break
        }

        return self
    }
}

/// AutoLayoutSugar UIView internal extension
internal extension UIView {

    func getRelatedViewOrParent(with relatedView: UIView? = nil) -> UIView {
        guard relatedView == nil else {
            return relatedView! // swiftlint:disable:this force_unwrapping
        }
        guard let superview = superview else {
            fatalError("No superview for your view and also parameter `view` is nil")
        }
        return superview
    }

    func anchorX(for side: LayoutPinnedSide) -> NSLayoutXAxisAnchor {
        switch side {
        case .right:
            return safeTrailingAnchor
        case .hCenter:
            return safeCenterXAnchor
        case .left:
            return safeLeadingAnchor
        default:
            fatalError("Something went wrong")
        }
    }

    func anchorX(for side: LayoutSideDirection) -> NSLayoutXAxisAnchor {
        switch side {
        case .right:
            return safeTrailingAnchor
        case .hCenter:
            return safeCenterXAnchor
        case .left:
            return safeLeadingAnchor
        default:
            fatalError("Something went wrong")
        }
    }

    func anchorY(for side: LayoutPinnedSide) -> NSLayoutYAxisAnchor {
        switch side {
        case .top:
            return safeTopAnchor
        case .vCenter:
            return safeCenterYAnchor
        case .bottom:
            return safeBottomAnchor
        default:
            fatalError("Something went wrong")
        }
    }
    func anchorY(for side: LayoutSideDirection) -> NSLayoutYAxisAnchor {
        switch side {
        case .top:
            return safeTopAnchor
        case .vCenter:
            return safeCenterYAnchor
        case .bottom:
            return safeBottomAnchor
        default:
            fatalError("Something went wrong")
        }
    }
}
