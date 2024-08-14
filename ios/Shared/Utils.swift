//
//  Utils.swift
//  Runner
//
//  Created by teko on 14/8/24.
//

import Foundation

extension EventParam {
    convenience init(event: Event) {
        self.init(identifier: event.id, display: event.name)
        self.name = event.name
    }
}
