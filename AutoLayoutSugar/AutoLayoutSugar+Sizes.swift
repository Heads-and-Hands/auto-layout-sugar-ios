//
//  AutoLayoutSugar+Sizes.swift
//  AutoLayoutSugar
//
//  Created by Handh on 19/08/2019.
//  Copyright © 2019 Heads and hands. All rights reserved.
//

import Foundation

/// Current view sizes modificators
public extension UIView {

    /// Update current view height constraint with new value
    ///
    /// - Parameters:
    ///   - value:          CGFloat value of new height
    ///
    /// - Returns: Current view.
    @discardableResult
    func height(_ value: CGFloat = 0.0) -> Self {
        heightAnchor =~ value
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
        heightAnchor =~ relatedView.heightAnchor
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
        widthAnchor =~ value
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
        widthAnchor =~ relatedView.widthAnchor
        return self
    }

}
