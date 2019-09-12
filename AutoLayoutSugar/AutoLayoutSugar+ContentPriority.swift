//
// Created by Handh on 2019-09-12.
// Copyright (c) 2019 Heads and hands. All rights reserved.
//

import UIKit

public enum ContentPriority {
    case equal
    case less
    case greater
}

public extension UIView {

    /// Set content hugging priority less, equal or greater than related view's hugging priority
    ///
    /// - Parameters:
    ///   - relation:       ContentPriority relation: equal, less, greater
    ///   - relatedView:    Related view
    ///   - axis:           NSLayoutConstraint.Axis
    ///
    /// - Returns: Current view.
    @discardableResult
    func hugging(
            _ relation: ContentPriority = ContentPriority.equal,
            than relatedView: UIView,
            _ axis: NSLayoutConstraint.Axis
    ) -> Self {
        var priorityRaw = relatedView.contentHuggingPriority(for: axis).rawValue
        switch relation {
        case .equal:
            break
        case .less:
            priorityRaw -= 1
        case .greater:
            priorityRaw += 1
        }
        let priority = UILayoutPriority(rawValue: priorityRaw)
        self.setContentHuggingPriority(priority, for: axis)
        return self
    }

    /// Set content hugging priority priority with rawValue
    ///
    /// - Parameters:
    ///   - rawValue:   UILayoutPriority priority raw value
    ///   - axis:       NSLayoutConstraint.Axis
    ///
    /// - Returns: Current view.
    @discardableResult
    func hugging(
            _ rawValue: Float,
            _ axis: NSLayoutConstraint.Axis
    ) -> Self {
        let priority = UILayoutPriority(rawValue: rawValue)
        self.setContentHuggingPriority(priority, for: axis)
        return self
    }

    /// Set content hugging priority priority
    ///
    /// - Parameters:
    ///   - priority:   UILayoutPriority priority value
    ///   - axis:       NSLayoutConstraint.Axis
    ///
    /// - Returns: Current view.
    @discardableResult
    func hugging(_ priority: UILayoutPriority, _ axis: NSLayoutConstraint.Axis) -> Self {
        self.setContentHuggingPriority(priority, for: axis)
        return self
    }

    /// Set content compression resistance priority less, equal or greater than related view's compression resistance priority
    ///
    /// - Parameters:
    ///   - relation:       ContentPriority relation: equal, less, greater
    ///   - relatedView:    Related view
    ///   - axis:           NSLayoutConstraint.Axis
    ///
    /// - Returns: Current view.
    @discardableResult
    func compressionResistance(
            _ relation: ContentPriority = ContentPriority.equal,
            than relatedView: UIView,
            _ axis: NSLayoutConstraint.Axis
    ) -> Self {
        var priorityRaw = relatedView.contentCompressionResistancePriority(for: axis).rawValue
        switch relation {
        case .equal:
            break
        case .less:
            priorityRaw -= 1
        case .greater:
            priorityRaw += 1
        }
        let priority = UILayoutPriority(rawValue: priorityRaw)
        self.setContentCompressionResistancePriority(priority, for: axis)
        return self
    }

    /// Set content compression resistance priority with rawValue
    ///
    /// - Parameters:
    ///   - rawValue:   UILayoutPriority priority raw value
    ///   - axis:       NSLayoutConstraint.Axis
    ///
    /// - Returns: Current view.
    @discardableResult
    func compressionResistance(_ rawValue: Float, _ axis: NSLayoutConstraint.Axis) -> Self {
        let priority = UILayoutPriority(rawValue: rawValue)
        self.setContentCompressionResistancePriority(priority, for: axis)
        return self
    }

    /// Set content compression resistance priority
    ///
    /// - Parameters:
    ///   - priority:   UILayoutPriority priority value
    ///   - axis:       NSLayoutConstraint.Axis
    ///
    /// - Returns: Current view.
    @discardableResult
    func compressionResistance(_ priority: UILayoutPriority, _ axis: NSLayoutConstraint.Axis) -> Self {
        self.setContentCompressionResistancePriority(priority, for: axis)
        return self
    }
}
