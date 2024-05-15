//
//  ContentView.swift
//  valoEsports
//
//  Created by Designare Karthikey on 21/04/24.
//

import SwiftUI
import Foundation

struct ContentView: View {
    
    var body: some View {
        VStack {
            Text("Val Scores")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity ,alignment: .leading)
                .foregroundColor(.init(uiColor: .label))
            
            
            TabView {
                ScoresView()
                    .tabItem {
                        Label("Matches", systemImage: "list.bullet.rectangle")
                    }
                
                UpcomingMatchesView()
                    .tabItem {
                        Label("Upcoming Matches", systemImage: "calendar.badge.clock")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
