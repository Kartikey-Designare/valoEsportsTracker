//
//  MatchHistoryBlock.swift
//  valoEsports
//
//  Created by Designare Karthikey on 22/04/24.
//

import SwiftUI

struct MatchHistoryBlock: View {
    @State private var image: UIImage?
    var matchHistory: Result
    
    //    init(matchHistory: Result) {
    //        self.matchHistory = matchHistory
    //    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Group {
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 48, height: 48)
                            .padding(5)
                            .background(.white)
                            .cornerRadius(8)
                        
                        
                    } else {
                        Text("Loading...")
                    }
                }
                .onAppear {
                    loadImageFromURL(matchHistory.tournament_icon)
                }
                
                Text(matchHistory.tournament_name)
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
            
            if (matchHistory.score1 > matchHistory.score2) {
                Text("\(matchHistory.team1) won with \(matchHistory.score1) - \(matchHistory.score2)")
                    .foregroundStyle(.white)
                    .bold()
                
            } else {
                Text("\(matchHistory.team2) won with \(matchHistory.score2) - \(matchHistory.score1)")
                    .foregroundStyle(.white)
                    .bold()
            }
            
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

let dat = Result(
    team1: "NRG Esports",
    team2: "Leviatán",
    score1: "1",
    score2: "2",
    flag1: "flag_us",
    flag2: "flag_cl",
    tournament_name: "Champions Tour 2024 Champions Tour 2024 Champions Tour 2024",
    tournament_icon: "https://owcdn.net/img/640f5ab71dfbb.png"
)

#Preview {
    MatchHistoryBlock(matchHistory: dat)
}
