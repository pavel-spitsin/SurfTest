//
//  NSLayoutConstraint+Extension.swift
//  SurfTest
//
//  Created by Павел on 01.08.2023.
//

import UIKit

extension NSLayoutConstraint {
    func withPriority(_ priority: Float) -> NSLayoutConstraint {
        self.priority = UILayoutPriority(priority)
        return self
    }
}
