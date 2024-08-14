import Intents

class IntentHandler: INExtension, EventSelectionIntentHandling {
    func provideEventOptionsCollection(for intent: EventSelectionIntent, with completion: @escaping (INObjectCollection<EventParam>?, (any Error)?) -> Void) {
        let events = loadEventData()
        let eventObjects = events.map { EventParam(event: Event(id: $0.id, name: $0.name)) }
        let collection = INObjectCollection(items: eventObjects)
        completion(collection, nil)
    }
    
    override func handler(for intent: INIntent) -> Any {
        return self
    }
    
    private func loadEventData() -> [Event] {
      let userDefaults = UserDefaults(suiteName: constAppGroup)
      if let eventData = userDefaults?.array(forKey: "eventData") as? [[String: String]] {
        return eventData.map { dict in
          Event(id: dict["name"] ?? "", name: dict["name"] ?? "")
        }
      }
      return []
    }
}
