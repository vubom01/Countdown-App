import WidgetKit
import SwiftUI
import Intents

struct CountdownWidgetEntry: TimelineEntry {
    let date: Date
    let events: [Event]
}

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> CountdownWidgetEntry {
        CountdownWidgetEntry(date: Date(), events: [])
    }

    func getSnapshot(for configuration: EventSelectionIntent, in context: Context, completion: @escaping (CountdownWidgetEntry) -> Void) {
        let entry = CountdownWidgetEntry(date: Date(), events: [])
        completion(entry)
    }

    func getTimeline(for configuration: EventSelectionIntent, in context: Context, completion: @escaping (Timeline<CountdownWidgetEntry>) -> Void) {
        let entry = CountdownWidgetEntry(date: Date(), events: getAllEvents())
        
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }

}

struct CountdownWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
      VStack(alignment: .leading) {
        ForEach(entry.events, id: \.name) { event in
          Text("\(event.name)")
            .font(.caption)
        }
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
