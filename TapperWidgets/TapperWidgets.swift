//
//  TapperWidgets.swift
//  TapperWidgets
//
//  Created by Yazan Tarifi on 19/01/2024.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct TapperWidgetsEntryView : View {
    
    public static let MONKEY_TESTING_DEEPLINK_KEY = "monkey-testing"
    public static let MAIN_DEEPLINK_KEY = "main"
    public static let GENERAL_DEEPLINK_KEY = "general"
    public static let DEVELOPER_DEEPLINK_KEY = "developers"
    public static let TESTING_DEEPLINK_KEY = "testings"
    
    var entry: Provider.Entry
    @Environment(\.openURL) var openUrl

    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .fill(Color("PrimaryColor"))
            
            HStack {
                Image("DeveloperOptionsIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .padding(8)
                    .background(Color("SecondColor"))
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    .onTapGesture {
                        guard let url = URL(string: "tapper://\(TapperWidgetsEntryView.DEVELOPER_DEEPLINK_KEY)") else {
                            return
                        }
                        
                        openUrl(url)
                    }
                
                Image("GeneralTestingOptionsIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .padding(8)
                    .background(Color("SecondColor"))
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    .onTapGesture {
                        guard let url = URL(string: "tapper://\(TapperWidgetsEntryView.GENERAL_DEEPLINK_KEY)") else {
                            return
                        }
                        
                        openUrl(url)
                    }
                
                Image("MonkeyTestingOptionsIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .padding(8)
                    .background(Color("SecondColor"))
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    .onTapGesture {
                        guard let url = URL(string: "tapper://\(TapperWidgetsEntryView.MONKEY_TESTING_DEEPLINK_KEY)") else {
                            return
                        }
                        
                        openUrl(url)
                    }
                
                Image("AutomaticTestingOptionsIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .padding(8)
                    .background(Color("SecondColor"))
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    .onTapGesture {
                        guard let url = URL(string: "tapper://\(TapperWidgetsEntryView.MAIN_DEEPLINK_KEY)") else {
                            return
                        }
                        
                        openUrl(url)
                    }
            }
            
        }
        .padding(4)
    }
}

struct TapperWidgets: Widget {
    let kind: String = "Tapper"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            TapperWidgetsEntryView(entry: entry)
                .containerBackground(Color("PrimaryColor"), for: .widget)
        }
        .configurationDisplayName("Tapper")
        .description("A Shortcuts of Common Android Development Commands")
        .supportedFamilies([.systemMedium])
    }
}
