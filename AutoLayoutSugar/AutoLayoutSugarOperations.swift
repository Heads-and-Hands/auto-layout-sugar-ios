//
//  AutoLayoutSugarOperations.swift
//  AutoLayoutSugar
//
//  Created by Handh on 15/08/2019.
//  Copyright © 2019 Heads and hands. All rights reserved.
//

import UIKit

public struct ConstraintMultiplierAttribute<T: AnyObject> {
    let anchor: NSLayoutAnchor<T>
    let multiplier: CGFloat
}

public struct LayoutGuideMultiplierAttribute {
    let guide: UILayoutSupport
    let multiplier: CGFloat
}

public struct ConstraintAttribute<T: AnyObject> {
    let anchor: NSLayoutAnchor<T>
    let const: CGFloat
}

public struct LayoutGuideAttribute {
    let guide: UILayoutSupport
    let const: CGFloat
}

// MARK: - Modifications

public func + <T>(lhs: NSLayoutAnchor<T>, rhs: CGFloat) -> ConstraintAttribute<T> {
    return ConstraintAttribute(anchor: lhs, const: rhs)
}

public func + (lhs: UILayoutSupport, rhs: CGFloat) -> LayoutGuideAttribute {
    return LayoutGuideAttribute(guide: lhs, const: rhs)
}

public func + <T>(lhs: ConstraintAttribute<T>, rhs: CGFloat) -> ConstraintAttribute<T> {
    return ConstraintAttribute(anchor: lhs.anchor, const: lhs.const + rhs)
}

public func - <T>(lhs: NSLayoutAnchor<T>, rhs: CGFloat) -> ConstraintAttribute<T> {
    return ConstraintAttribute(anchor: lhs, const: -rhs)
}

public func - (lhs: UILayoutSupport, rhs: CGFloat) -> LayoutGuideAttribute {
    return LayoutGuideAttribute(guide: lhs, const: -rhs)
}

public func - <T>(lhs: ConstraintAttribute<T>, rhs: CGFloat) -> ConstraintAttribute<T> {
    return ConstraintAttribute(anchor: lhs.anchor, const: lhs.const - rhs)
}

public func * <T>(lhs: NSLayoutAnchor<T>, rhs: CGFloat) -> ConstraintMultiplierAttribute<T> {
    return ConstraintMultiplierAttribute(anchor: lhs, multiplier: rhs)
}

public func * (lhs: UILayoutSupport, rhs: CGFloat) -> LayoutGuideMultiplierAttribute {
    return LayoutGuideMultiplierAttribute(guide: lhs, multiplier: rhs)
}

public func * <T>(lhs: ConstraintMultiplierAttribute<T>, rhs: CGFloat) -> ConstraintMultiplierAttribute<T> {
    return ConstraintMultiplierAttribute(anchor: lhs.anchor, multiplier: rhs)
}

// MARK: - Equatable operations

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

// MARK: - Less/Greather than operations

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
public func ~> <T>(lhs: NSLayoutAnchor<T>, rhs: ConstraintAttribute<T>) -> NSLayoutConstraint {
    let constraint = lhs.constraint(greaterThanOrEqualTo: rhs.anchor, constant: rhs.const)
    return constraint.activate()
}

@discardableResult
public func ~> (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    let constraint = lhs.constraint(greaterThanOrEqualToConstant: rhs)
    return constraint.activate()
}

precedencegroup AutoLayoutSugarPrecedence {
    higherThan: ComparisonPrecedence
    lowerThan: AdditionPrecedence
}

infix operator ~: AutoLayoutSugarPrecedence
infix operator <~: AutoLayoutSugarPrecedence
infix operator ~>: AutoLayoutSugarPrecedence
