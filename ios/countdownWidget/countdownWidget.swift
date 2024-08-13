import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), events: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), events: loadEventData())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, events: loadEventData())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

    private func loadEventData() -> [Event] {
        let userDefaults = UserDefaults(suiteName: "group.com.vulh")
        if let eventData = userDefaults?.array(forKey: "eventData") as? [[String: String]] {
            return eventData.map { dict in
                Event(name: dict["name"] ?? "", date: dict["date"] ?? "", time: dict["time"])
            }
        }
        return []
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let events: [Event]
}

struct Event {
    let name: String
    let date: String
    let time: String?
}

struct CountdownWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(entry.events, id: \.name) { event in
                Text("\(event.name) - \(event.date) \(event.time ?? "")")
                    .font(.caption)
            }
        }
        .padding()
    }
}

struct CountdownWidget: Widget {
    let kind: String = "CountdownWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            CountdownWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Countdown Widget")
        .description("This widget displays upcoming events.")
    }
}
