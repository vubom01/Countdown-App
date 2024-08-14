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
        let entry = CountdownWidgetEntry(date: Date(), event: getEventById(id: configuration.event?.identifier))
        
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }

}

struct CountdownWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
      VStack(alignment: .leading) {
          Text(entry.event?.name ?? "")
            .font(.caption)
      }
      .padding()
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
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
