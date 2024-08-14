import Intents

class EventSelectionIntent: INIntent {
    @NSManaged public var eventName: String?
}

extension EventSelectionIntent: INIntentHandlerProviding {
    func handler(for intent: INIntent) -> Any? {
        guard let intent = intent as? EventSelectionIntent else {
            return nil
        }
        return EventSelectionIntentHandler()
    }
}

class EventSelectionIntentHandler: NSObject, EventSelectionIntentHandling {
    func handle(intent: EventSelectionIntent, completion: @escaping (EventSelectionIntentResponse) -> Void) {
        let eventName = intent.eventName ?? "Default Event"
        // Handle the intent and create a response
        let response = EventSelectionIntentResponse(code: .success, userActivity: nil)
//        response.eventName = eventName
        completion(response)
    }

    func resolveEventName(for intent: EventSelectionIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        // Resolve the event name if necessary
        let eventName = intent.eventName ?? ""
        completion(INStringResolutionResult.success(with: eventName))
    }
}
