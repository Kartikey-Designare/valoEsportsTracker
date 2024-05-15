//
//  UpcomingMatchesView.swift
//  valoEsports
//
//  Created by Designare Karthikey on 29/04/24.
//

import SwiftUI

struct UpcomingMatchesView: View {
    @State var upcomingMatches: [UpcomingMatches]?
    
    var body: some View {
        ScrollView {
            Text("Upcoming Matches")
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity ,alignment: .leading)
                .foregroundColor(.init(uiColor: .label))
            
            if let upcomingMatches {
                ForEach(upcomingMatches.indices, id: \.self) { index in
                    UpcomingMatchesBlock(upcomingMatches: upcomingMatches[index])
                }
            } else {
                Text("No data available")
            }
        }
        .padding(8)
        .task {
            do {
                upcomingMatches = try await getUpcomingMatches()
            } catch {
                print("err in upcoming matches")
                upcomingMatches = nil
            }
        }
    }
}

#Preview {
    UpcomingMatchesView()
}
