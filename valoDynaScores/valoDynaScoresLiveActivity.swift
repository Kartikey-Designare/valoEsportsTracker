//
//  valoDynaScoresLiveActivity.swift
//  valoDynaScores
//
//  Created by Designare Karthikey on 30/04/24.
//

import Foundation
import ActivityKit
import WidgetKit
import SwiftUI

struct valoDynaScoresAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var score1: String
        var score2: String
    }
    
    // Fixed non-changing properties about your activity go here!
    var team1: String
    var team2: String
    
}

struct valoDynaScoresLiveActivity: Widget, Codable {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: valoDynaScoresAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Match between \(context.attributes.team1) and \(context.attributes.team2)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)
            
        }
    dynamicIsland: { 
        context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("\(context.attributes.team1)")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("\(context.attributes.team2)")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("\(context.state.score1) - \(context.state.score2)")
                    // more contenž
                }
            } compactLeading: {
                Text(
                    "\(String(context.attributes.team1.first ?? "-").uppercased())-\(context.state.score1)")
            } compactTrailing: {
                Text(
                    "\(String(context.attributes.team2.first ?? "-").uppercased())-\(context.state.score2)")
            } minimal: {
                Text("\(context.state.score1)-\(context.state.score2)")
            }
            //            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension valoDynaScoresAttributes {
    fileprivate static var preview: valoDynaScoresAttributes {
        valoDynaScoresAttributes(team1: "team1", team2: "team2")
    }
}

extension valoDynaScoresAttributes.ContentState {
    fileprivate static var smiley: valoDynaScoresAttributes.ContentState {
        valoDynaScoresAttributes.ContentState(score1: "1", score2: "2")
    }
    
    fileprivate static var starEyes: valoDynaScoresAttributes.ContentState {
        valoDynaScoresAttributes.ContentState(score1: "0", score2: "0")
    }
}

#Preview("Notification", as: .content, using: valoDynaScoresAttributes.preview) {
    valoDynaScoresLiveActivity()
} contentStates: {
    valoDynaScoresAttributes.ContentState.smiley
    valoDynaScoresAttributes.ContentState.starEyes
}
