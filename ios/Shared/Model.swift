//
//  Model.swift
//  Runner
//
//  Created by teko on 14/8/24.
//

import Foundation

struct Event: Decodable {
    let id: String
    let name: String
    let date: String
    let time: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "Slug"
        case name = "Event"
        case date = "Date"
        case time = "Time"
    }
}
