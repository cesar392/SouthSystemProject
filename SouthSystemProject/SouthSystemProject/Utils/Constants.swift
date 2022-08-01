//
//  Constants.swift
//  SouthSystemProject
//
//  Created by Cesar Comelli on 31/07/22.
//

import Foundation
import CoreGraphics

class Constants {
    public static let APIURL = "http://5f5a8f24d44d640016169133.mockapi.io/api/"
    public static let defaultPadding: CGFloat = 16
}

enum Endpoints: String {
    case events
    case checkin
}

extension Int {
    var cgFloat: CGFloat {
        CGFloat(self)
    }
}
