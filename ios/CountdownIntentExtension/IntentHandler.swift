import Intents

class IntentHandler: INExtension, EventSelectionIntentHandling {
    func provideEventOptionsCollection(for intent: EventSelectionIntent, with completion: @escaping (INObjectCollection<EventParam>?, (any Error)?) -> Void) {
        let events = getAllEvents()
        let eventObjects = events.map { EventParam(event: Event(id: $0.id, name: $0.name, date: $0.date, time: $0.time)) }
        let collection = INObjectCollection(items: eventObjects)
        completion(collection, nil)
    }
    
    override func handler(for intent: INIntent) -> Any {
        return self
    }

}
