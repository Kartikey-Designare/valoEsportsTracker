//
//  UpcomingMatchesBlock.swift
//  valoEsports
//
//  Created by Designare Karthikey on 29/04/24.
//

import SwiftUI

struct UpcomingMatchesBlock: View {
    @State private var image: UIImage?
    var upcomingMatches: UpcomingMatches
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(upcomingMatches.match_event)
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                VStack {
                    Text(upcomingMatches.team1)
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                }
                
                Text("v/s")
                    .bold()
                    .foregroundStyle(.white)
                
                VStack {
                    Text(upcomingMatches.team2)
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                }
            }
            
            Divider()
            
            Text("Live in \(upcomingMatches.time_until_match)")
                .font(.title3)
                .bold()
                .foregroundStyle(.white)
            
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(red: 0.3, green: 0.5, blue: 0.8, opacity: 1))
        .cornerRadius(16)
    }
    
    
    private func loadImageFromURL(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}

let dat22 = UpcomingMatches(
    team1: "NRG Esports",
    team2: "Leviatán",
    flag1: "flag_us",
    flag2: "flag_cl",
    match_event: "Champions Tour 2024 Champions Tour 2024 Champions Tour 2024",
    time_until_match: "8h 45m from now"
)

#Preview {
    UpcomingMatchesBlock(upcomingMatches: dat22)
}
