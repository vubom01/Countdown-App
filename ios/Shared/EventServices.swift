//
//  EventServices.swift
//  Runner
//
//  Created by teko on 14/8/24.
//

import Foundation

func getAllEvents() -> [Event] {
  let userDefaults = UserDefaults(suiteName: constAppGroup)
  if let eventData = userDefaults?.array(forKey: constEventsKey) as? [[String: String]] {
    return eventData.map { dict in
        Event(id: dict["id"] ?? "", name: dict["name"] ?? "", date: dict["date"] ?? "", time: dict["time"] ?? "s")
    }
  }
  return []
}

func getEventById(id: String?) -> Event? {
    let events = getAllEvents()
    return events.first { $0.id == id }
}
