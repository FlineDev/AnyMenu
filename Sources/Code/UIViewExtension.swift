//
//  UIViewExtension.swift
//  AnyMenu
//
//  Created by Murat Yilmaz on 12.09.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import UIKit

extension UIView {
    /**

     Returns the views whose types matches the specified value.

     - note: This method searches the current view and all of its subviews for the specified views.

     - parameters:
     - type The `Type` value to search for.

     - returns: `Array<Type>` Array with the views in the receiver’s hierarchy whose types match the value in the `Type` parameter.

     */
    internal func viewsOfType<T: UIView>(_ type: T.Type) -> [T] {
        var results = [T]()
        var stack: [UIView] = [self]

        while !stack.isEmpty {
            if let view = stack.popLast() {
                if let view = view as? T {
                    results.append(view)
                }

                stack.append(contentsOf: view.subviews)
            }
        }

        return results
    }

    /**

     Returns the view whose type matches the specified value.

     - note: This method searches the current view and all of its subviews for the specified view.

     - parameters:
     - type The `Type` value to search for.

     - returns: `Optional(Type)` The view in the receiver’s hierarchy whose type matches the value in the `Type` parameter or nil if not found.

     */
    internal func viewOfType<T: UIView>(_ type: T.Type) -> T? {
        var stack: [UIView] = [self]

        while !stack.isEmpty {
            if let view = stack.popLast() {
                if let view = view as? T {
                    return view
                }

                stack.append(contentsOf: view.subviews)
            }
        }

        return nil
    }
}
