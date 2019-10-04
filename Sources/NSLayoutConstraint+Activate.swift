//
//  NSLayoutConstraint+Activate.swift
//  AutoLayoutSugar
//
//  Created by Handh on 15/08/2019.
//  Copyright © 2019 Heads and hands. All rights reserved.
//

import UIKit

public extension NSLayoutConstraint {

    @discardableResult
    func activate() -> Self {
        isActive = true
        return self
    }

}
