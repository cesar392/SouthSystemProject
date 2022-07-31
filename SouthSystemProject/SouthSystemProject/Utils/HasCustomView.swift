//
//  HasCustomView.swift
//  SouthSystemProject
//
//  Created by Cesar Comelli on 31/07/22.
//

import UIKit

/// The HasCustomView protocol defines a customView property for UIViewControllers to be used in exchange of the regular view property.
/// In order for this to work, you have to provide a custom view to your UIViewController at the loadView() method.
public protocol HasCustomView {
    associatedtype ContentView: UIView
}

extension HasCustomView where Self: UIViewController {
    /// The UIViewController's custom view.
    public var contentView: ContentView {
        guard let customView = view as? ContentView else {
            fatalError("Expected view to be of type \(ContentView.self) but got \(type(of: view)) instead")
        }
        return customView
    }
}
