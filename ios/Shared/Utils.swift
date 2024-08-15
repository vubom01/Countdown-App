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

func convertToDateTime(date: String?, time: String?) -> Date {
    let dateTimeString = "\(date ?? "") \(time ?? "00:00")"
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
    return dateFormatter.date(from: dateTimeString) ?? Date()
}
