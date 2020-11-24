//
//  AutoLayoutSugarOperations.swift
//  AutoLayoutSugar
//
//  Created by Handh on 15/08/2019.
//  Copyright © 2019 Heads and hands. All rights reserved.
//

import UIKit

public struct ConstraintMultiplierAttribute<T: AnyObject> {
    public let anchor: NSLayoutAnchor<T>
    public let multiplier: CGFloat
}

public struct LayoutGuideMultiplierAttribute {
    public let guide: UILayoutSupport
    public let multiplier: CGFloat
}

public struct ConstraintAttribute<T: AnyObject> {
    public let anchor: NSLayoutAnchor<T>
    public let const: CGFloat
}

public struct LayoutGuideAttribute {
    public let guide: UILayoutSupport
    public let const: CGFloat
}

// MARK: - Modifications

public func + <T>(lhs: NSLayoutAnchor<T>, rhs: CGFloat) -> ConstraintAttribute<T> {
    ConstraintAttribute(anchor: lhs, const: rhs)
}

public func + (lhs: UILayoutSupport, rhs: CGFloat) -> LayoutGuideAttribute {
    LayoutGuideAttribute(guide: lhs, const: rhs)
}

public func + <T>(lhs: ConstraintAttribute<T>, rhs: CGFloat) -> ConstraintAttribute<T> {
    ConstraintAttribute(anchor: lhs.anchor, const: lhs.const + rhs)
}

public func - <T>(lhs: NSLayoutAnchor<T>, rhs: CGFloat) -> ConstraintAttribute<T> {
    ConstraintAttribute(anchor: lhs, const: -rhs)
}

public func - (lhs: UILayoutSupport, rhs: CGFloat) -> LayoutGuideAttribute {
    LayoutGuideAttribute(guide: lhs, const: -rhs)
}

public func - <T>(lhs: ConstraintAttribute<T>, rhs: CGFloat) -> ConstraintAttribute<T> {
    ConstraintAttribute(anchor: lhs.anchor, const: lhs.const - rhs)
}

public func * <T>(lhs: NSLayoutAnchor<T>, rhs: CGFloat) -> ConstraintMultiplierAttribute<T> {
    ConstraintMultiplierAttribute(anchor: lhs, multiplier: rhs)
}

public func * (lhs: UILayoutSupport, rhs: CGFloat) -> LayoutGuideMultiplierAttribute {
    LayoutGuideMultiplierAttribute(guide: lhs, multiplier: rhs)
}

public func * <T>(lhs: ConstraintMultiplierAttribute<T>, rhs: CGFloat) -> ConstraintMultiplierAttribute<T> {
    ConstraintMultiplierAttribute(anchor: lhs.anchor, multiplier: rhs)
}

//
// MARK: - Equatable operations
//         [!!!] All operations below create new constraint with default (required) priority.
//         Mutating a priority from required to not on an installed constraint will crash your app in runtime
//

@discardableResult
public func ~ <T>(lhs: NSLayoutAnchor<T>, rhs: NSLayoutAnchor<T>) -> NSLayoutConstraint {
    let constraint = lhs.constraint(equalTo: rhs).activate()
    return constraint
}

@discardableResult
public func ~ <T>(lhs: NSLayoutAnchor<T>, rhs: ConstraintAttribute<T>) -> NSLayoutConstraint {
    let constraint = lhs.constraint(equalTo: rhs.anchor, constant: rhs.const).activate()
    return constraint
}

@discardableResult
public func ~ (lhs: NSLayoutXAxisAnchor, rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
    let constraint = lhs.constraint(equalTo: rhs)
    return constraint.activate()
}

@discardableResult
public func ~ (lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
    let constraint = lhs.constraint(equalTo: rhs)
    return constraint.activate()
}

@discardableResult
public func ~ (lhs: NSLayoutYAxisAnchor, rhs: UILayoutSupport) -> NSLayoutConstraint {
    let constraint = lhs.constraint(equalTo: rhs.bottomAnchor)
    return constraint.activate()
}

@discardableResult
public func ~ (lhs: NSLayoutYAxisAnchor, rhs: LayoutGuideAttribute) -> NSLayoutConstraint {
    let constraint = lhs.constraint(equalTo: rhs.guide.bottomAnchor, constant: rhs.const)
    return constraint.activate()
}

@discardableResult
public func ~ (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    let constraint = lhs.constraint(equalToConstant: rhs)
    return constraint.activate()
}

@discardableResult
public func ~ (lhs: NSLayoutDimension, rhs: NSLayoutDimension) -> NSLayoutConstraint {
    let constraint = lhs.constraint(equalTo: rhs)
    return constraint.activate()
}

//
// MARK: - Less/Greater than operations
//         [!!!] All operations below create new constraint with default (required) priority.
//         Mutating a priority from required to not on an installed constraint will crash your app in runtime
//

@discardableResult
public func <~ <T>(lhs: NSLayoutAnchor<T>, rhs: ConstraintAttribute<T>) -> NSLayoutConstraint {
    let constraint = lhs.constraint(lessThanOrEqualTo: rhs.anchor, constant: rhs.const)
    return constraint.activate()
}

@discardableResult
public func <~ (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    let constraint = lhs.constraint(lessThanOrEqualToConstant: rhs)
    return constraint.activate()
}

@discardableResult
public func >~ <T>(lhs: NSLayoutAnchor<T>, rhs: ConstraintAttribute<T>) -> NSLayoutConstraint {
    let constraint = lhs.constraint(greaterThanOrEqualTo: rhs.anchor, constant: rhs.const)
    return constraint.activate()
}

@discardableResult
public func >~ (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    let constraint = lhs.constraint(greaterThanOrEqualToConstant: rhs)
    return constraint.activate()
}

precedencegroup AutoLayoutSugarPrecedence {
    associativity: left
    higherThan: ComparisonPrecedence
    lowerThan: AdditionPrecedence
}

infix operator ~ : AutoLayoutSugarPrecedence
infix operator <~ : AutoLayoutSugarPrecedence
infix operator >~ : AutoLayoutSugarPrecedence
