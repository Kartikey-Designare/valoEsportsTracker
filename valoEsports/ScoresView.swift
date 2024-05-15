//
//  ScoresView.swift
//  valoEsports
//
//  Created by Designare Karthikey on 29/04/24.
//

import SwiftUI
import ActivityKit

struct ScoresView: View {
    @State var live: [LiveResult]?
    @State var result: [Result]?
    
    struct watchingStruct {
        var result: LiveResult?
        var index: Int?
    }
    
    @State var watching = watchingStruct()
    
    @State private var activity: Activity<valoDynaScoresAttributes>? = nil
    
    func start() {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            print("Activities are not enabled")
            return
        }
        
        let attr = valoDynaScoresAttributes(team1: watching.result?.team1 ?? "team2", team2: watching.result?.team2 ?? "team2")
        let initialState = valoDynaScoresAttributes.ContentState(
            score1: watching.result?.score1 ?? "0", score2: watching.result?.score2 ?? "0"
        )
        
        activity = try? Activity<valoDynaScoresAttributes>.request(
            attributes: attr,
            content: .init(state: initialState, staleDate: nil),
            pushType: nil
        )
    }
    
    func stop() {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            print("Activities are not enabled")
            return
        }
        
        let state = valoDynaScoresAttributes.ContentState(score1: watching.result?.score1 ?? "0", score2: watching.result?.score2 ?? "0")
        
        Task {
            await activity?.end(.init(state: state, staleDate: nil), dismissalPolicy: .immediate)
        }
    }
    
    //    func update() {
    //        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
    //            print("Activities are not enabled")
    //            return
    //        }
    //
    //        let state = valoDynaScoresAttributes.ContentState(
    //            score1: "0", score2: "0"
    //        )
    //
    //        Task {
    //            await activity?.update(.init(state: state, staleDate: nil, relevanceScore: 0))
    //        }
    //    }
    
    var body: some View {
        ScrollView {
            if let live {
                if (live.count > 0) {
                    Text("*live now*")
                        .foregroundStyle(.red)
                        .font(.title2)
                        .frame(maxWidth: .infinity ,alignment: .leading)
                    
                    
                    ForEach(live.indices, id: \.self) { index in
                        LiveMatchBlock(matchHistory: live[index])
                            .onTapGesture {
                                watching.index = index
                                watching.result = live[index]
                                stop()
                                start()
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(Color.yellow, lineWidth: index == watching.index ? 2 : 0)
                            )
                    }
                }
                else {
                    Text("No Live Match")
                        .font(.title2)
                        .frame(maxWidth: .infinity ,alignment: .leading)
                        .foregroundStyle(.white)
                }
            } else {
                Text("No Live Match")
                    .font(.title)
                    .frame(maxWidth: .infinity ,alignment: .leading)
                    .foregroundStyle(.white)
            }
            
            
            if let result {
                ForEach(result.indices, id: \.self) { index in
                    MatchHistoryBlock(matchHistory: result[index])
                }
            } else {
                Text("No data available")
            }
        }
        .padding(8)
        .task {
            do {
                result = try await getMatchResults()
            } catch {
                print("err in history")
                result = nil
            }
            
            do {
                live = try await getLiveMatch()
            } catch {
                print("err in live")
                live = nil
            }
        }
    }
}

#Preview {
    ScoresView()
}
