//
//  LayoutPinnedSide.swift
//  AutoLayoutSugar
//
//  Created by Handh on 15/08/2019.
//  Copyright © 2019 Heads and hands. All rights reserved.
//

import Foundation

private enum CommonSideRawValues {
    static let top: String = "top"
    static let left: String = "left"
    static let right: String = "right"
    static let bottom: String = "bottom"
}

internal protocol LayoutSideProtocol {
    var rawValue: String { get }
}

/// LayoutPinnedSide used when we need to determine inset from concrete side
public enum LayoutPinnedSide: Hashable, RawRepresentable, LayoutSideProtocol {
    public typealias RawValue = String

    case top(_: CGFloat)
    case left(_: CGFloat)
    case right(_: CGFloat)
    case bottom(_: CGFloat)

    var offset: CGFloat {
        switch self {
        case .top(let value), .left(let value), .right(let value), .bottom(let value):
            return value
        }
    }

    public var rawValue: LayoutPinnedSide.RawValue {
        switch self {
        case .top:
            return CommonSideRawValues.top
        case .left:
            return CommonSideRawValues.left
        case .right:
            return CommonSideRawValues.right
        case .bottom:
            return CommonSideRawValues.bottom
        }
    }

    public init?(rawValue: LayoutPinnedSide.RawValue) {
        return nil
    }
}

/// LayoutSideDirection used when we don't need insets from concrete side
public enum LayoutSideDirection: Hashable, RawRepresentable, LayoutSideProtocol {
    public typealias RawValue = String

    case top
    case left
    case right
    case bottom

    public var rawValue: LayoutSideDirection.RawValue {
        switch self {
        case .top:
            return CommonSideRawValues.top
        case .left:
            return CommonSideRawValues.left
        case .right:
            return CommonSideRawValues.right
        case .bottom:
            return CommonSideRawValues.bottom
        }
    }

    public init?(rawValue: LayoutPinnedSide.RawValue) {
        return nil
    }
}
