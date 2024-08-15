import WidgetKit
import SwiftUI
import Intents
import Foundation

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
        
        let currentDate = Date()
        var entries: [CountdownWidgetEntry] = []
        
        for secondOffset in 0...3600 {
              let entryDate = Calendar.current.date(byAdding: .second, value: secondOffset, to: currentDate)!
              let entry = CountdownWidgetEntry(date: entryDate, event: event)
            entries.append(entry)
          }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

}

struct CountdownWidgetEntryView: View {
    @State private var currentDate: Date = Date()

    var entry: Provider.Entry

    var body: some View {
      let targetDate = convertToDateTime(date: entry.event?.date, time: entry.event?.time)

      VStack(alignment: .center, spacing: 8) {
          Text(entry.event?.name ?? "")
              .font(Font.system(.title2, design: .monospaced))
              .foregroundStyle(.white)
          let remainingTime = targetDate.timeIntervalSince(entry.date)
          Text(timeString(from: remainingTime))
              .multilineTextAlignment(.center)
              .font(Font.system(size: 16, design: .monospaced))
              .foregroundStyle(.white)
      }
      .padding()
      .widgetBackground(backgroundView: Color.black)
    }
    
    func timeString(from interval: TimeInterval) -> String {
        let totalSeconds = Int(interval)
        let days = totalSeconds / 86400 // 24 * 3600
        let hours = (totalSeconds % 86400) / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d:%02d:%02d", days, hours, minutes, seconds)
    }
}

extension View {
    func widgetBackground(backgroundView: some View) -> some View {
        if #available(watchOS 10.0, iOSApplicationExtension 17.0, iOS 17.0, macOSApplicationExtension 14.0, *) {
            return containerBackground(for: .widget) {
                backgroundView
            }
        } else {
            return background(backgroundView)
        }
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
