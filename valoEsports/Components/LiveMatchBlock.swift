//
//  LiveMatchBlock.swift
//  valoEsports
//
//  Created by Designare Karthikey on 23/04/24.
//

import SwiftUI

struct LiveMatchBlock: View {
    @State private var image: UIImage?
    var matchHistory: LiveResult
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(matchHistory.match_event)
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            
            HStack {
                VStack {
                    Text(matchHistory.team1)
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                }
                
                Text("v/s")
                    .bold()
                    .foregroundStyle(.white)
                
                
                VStack {
                    Text(matchHistory.team2)
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                }
            }
            
            Text("\(matchHistory.score1) - \(matchHistory.score2)")
                .foregroundStyle(.white)
                .bold()
            
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(red: 0.2, green: 0.6, blue: 0.4, opacity: 1))
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

let dat2 = LiveResult(
    team1: "NRG Esports",
    team2: "Leviatán",
    score1: "1",
    score2: "0",
    flag1: "flag_us",
    flag2: "flag_cl",
    match_event: "Champions Tour 2024 Champions Tour 2024 Champions Tour 2024"
)

#Preview {
    LiveMatchBlock(matchHistory: dat2)
}
