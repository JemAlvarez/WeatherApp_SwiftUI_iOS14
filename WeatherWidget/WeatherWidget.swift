//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct HourlyView : View {
    var body: some View {
        VStack {
            Text("1AM")
                .font(.system(size: 12))
                .opacity(0.5)
            
            Spacer()
            
            Image("thunderstorm")
                .resizable()
                .scaledToFit()
                .frame(width: 30)
            
            Spacer()
            
            Text("84º")
                .font(.system(size: 12))
        }
        .frame(height: 70)
    }
}

struct WeatherWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        if family == .systemSmall {
            VStack {
                HStack {
                    Text("London")
                        .padding(7)
                        .padding(.horizontal, 5)
                        .background(Color("backgroundLight"))
                        .border(Color("purple"), width: 3)
                        .cornerRadius(5)
                    
                    Spacer()
                    
                    Text(entry.date, style: .time)
                }
                .font(.system(size: 11))
                
                Spacer()
                
                VStack {
                    Image("clear_sky")
                        .resizable()
                        .scaledToFit()
                    
                    Text("Clear Sky")
                        .font(.system(size: 12))
                        .opacity(0.5)
                }
                
                Spacer()
                
                HStack {
                    VStack (alignment: .leading) {
                        HStack {
                            Image(systemName: "wind")
                                .frame(width: 20)
                                .opacity(0.5)
                            Text("11 km/h")
                        }
                        
                        HStack {
                            Image(systemName: "drop")
                                .frame(width: 20)
                                .opacity(0.5)
                            Text("25%")
                        }
                    }
                    .font(.system(size: 13))
                    
                    Spacer()
                    
                    Text("8º")
                        .font(.system(size: 35))
                }
            }
            .padding()
            .background(Color("background"))
            .foregroundColor(.white)
        } else if family == .systemMedium {
            VStack (spacing: 0) {
                HStack {
                    Text("Miami")
                        .font(.system(size: 15))
                    
                    Spacer()
                    
                    Image("thunderstorm")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                }
                HStack {
                    Text("84º")
                        .font(.system(size: 30))
                    
                    Spacer()
                    
                    VStack {
                        Text("Partly Cloud")
                        HStack(spacing: 5) {
                            Text("H: 88º")
                            Text("L: 71º")
                                .opacity(0.5)
                        }
                    }
                    .font(.system(size: 13))
                }
                
                Spacer()
                
                HStack {
                    ForEach(0..<6) {i in
                        HourlyView()
                        if i != 5 {
                            Spacer()
                        }
                    }
                }
            }
            .padding()
            .background(Color("background"))
            .foregroundColor(.white)
        }
    }
}

@main
struct WeatherWidget: Widget {
    let kind: String = "WeatherWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            WeatherWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct WeatherWidget_Previews: PreviewProvider {
    static var previews: some View {
        WeatherWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
