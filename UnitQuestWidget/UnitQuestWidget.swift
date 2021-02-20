//
//  UnitQuestWidget.swift
//  UnitQuestWidget
//
//  Created by Asad Mansoor (LCL) on 2021-02-20.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    
    func unit(for configuration: ConfigurationIntent) -> UnitDetail {
        switch configuration.unit {
        case .knight:
            return .warrior
        
        case .wizard:
            return .wizard
        default:
            return .warrior
        }
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), unit: .wizard)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, unit: .wizard)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        let selectedUnit = unit(for: configuration)
        let entries: [SimpleEntry] = [SimpleEntry(date: Date(), configuration: configuration, unit: selectedUnit)]

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, configuration: configuration)
//            entries.append(entry)
//        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let unit: UnitDetail
}

struct UnitQuestWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        UnitView(entry.unit)
            .widgetURL(entry.unit.url)
    }
}

@main
struct UnitQuestWidget: Widget {
    let kind: String = "UnitQuestWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            UnitQuestWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Unit Quest Detail")
        .description("Track your favourite unit and their quest.")
        .supportedFamilies([.systemSmall])
    }
}
