//
//  Constants.swift
//  SouthSystemProject
//
//  Created by Cesar Comelli on 31/07/22.
//

import Foundation
import CoreGraphics

class Constants {
    public static let eventsURL = "http://5f5a8f24d44d640016169133.mockapi.io/api/events"
    public static let defaultPadding: CGFloat = 16
}

extension Int {
    var cgFloat: CGFloat {
        CGFloat(self)
    }
}
