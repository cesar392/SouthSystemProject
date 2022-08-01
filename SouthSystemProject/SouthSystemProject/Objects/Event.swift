//
//  EventObject.swift
//  SouthSystemProject
//
//  Created by Cesar Comelli on 31/07/22.
//

import Foundation

struct Event: Codable {
    var people: [People]
    let id: String
    let date: Int
    let description: String
    let image: String
    let longitude: Double
    let latitude: Double
    let price: Double
    let title: String
}
