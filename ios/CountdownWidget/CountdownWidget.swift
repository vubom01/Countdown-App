import WidgetKit
import SwiftUI
import Intents

struct CountdownWidgetEntry: TimelineEntry {
    let date: Date
    let event: Event?
}

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> CountdownWidgetEntry {
        CountdownWidgetEntry(date: Date(), event: Event(id: "id", name: "name", date: "date", time: "time"))
    }

    func getSnapshot(for configuration: EventSelectionIntent, in context: Context, completion: @escaping (CountdownWidgetEntry) -> Void) {
        let entry = CountdownWidgetEntry(date: Date(), event: getEventById(id: configuration.event?.identifier))
        completion(entry)
    }

    func getTimeline(for configuration: EventSelectionIntent, in context: Context, completion: @escaping (Timeline<CountdownWidgetEntry>) -> Void) {
        guard let event = getEventById(id: configuration.event?.identifier) else {
            let timeline = Timeline(entries: [CountdownWidgetEntry(date: Date(), event: nil)], policy: .atEnd)
            completion(timeline)
            return
        }
        
        var entries: [CountdownWidgetEntry] = []
        let currentDate = Date()
        let targetDate = convertToDateTime(date: event.date, time: event.time) ?? currentDate
        
        for secondOffset in 0...3600 { // Generates 3600 entries (1 hour)
            let entryDate = Calendar.current.date(byAdding: .second, value: secondOffset, to: currentDate)!
            let entry = CountdownWidgetEntry(date: entryDate, event: event)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

}

struct CountdownWidgetEntryView: View {
    @State private var currentDate = Date()
    var entry: Provider.Entry
    
    var body: some View {
        let targetDate = convertToDateTime(date: entry.event?.date, time: entry.event?.time) ?? currentDate
        VStack {
            if let event = entry.event {
                Text(event.name)
                    .font(.headline)
                
                let remainingTime = targetDate.timeIntervalSince(entry.date)
                Text(timeString(from: remainingTime))
                    .font(.largeTitle)
                    .bold()
            } else {
                Text("No Event")
                    .font(.headline)
            }
        }
        .padding()
    }
    func timeString(from interval: TimeInterval) -> String {
        let day = Int(interval) / 3600 / 24
        let hours = (Int(interval) % 86400) / 3600
        let minutes = (Int(interval) % 3600) / 60
        let seconds = Int(interval) % 60
        return String(format: "%02d:%02d:%02d:%02d", day, hours, minutes, seconds)
    }
}

struct CountdownWidget: Widget {
    let kind: String = "CountdownWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: EventSelectionIntent.self, provider: Provider()) { entry in
            CountdownWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Countdown Widget")
        .description("Displays the selected event.")
    }
}
