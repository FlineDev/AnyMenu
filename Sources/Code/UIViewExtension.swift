//
//  UIViewExtension.swift
//  AnyMenu
//
//  Created by Murat Yilmaz on 12.09.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import UIKit

extension UIView {
    /// Returns the views whose types match the specified value potentially including the view itself.
    ///
    /// - Note: This method searches the current view and all of its subviews for the specified views.
    ///
    /// - Parameters:
    ///   - type: The `Type` value to search for.
    ///
    /// - Returns: Array with the views in the receiver’s hierarchy whose types match.
    internal func viewsInHierarchy<T: UIView>(ofType type: T.Type) -> [T] {
        let viewsFoundInSubviews = subviews.map { $0.viewsInHierarchy(ofType: T.self) }.joined()

        guard let expectedTypeSelf = self as? T else { return Array(viewsFoundInSubviews) }
        return [expectedTypeSelf] + Array(viewsFoundInSubviews)
    }
}
