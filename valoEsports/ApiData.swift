//
//  ApiData.swift
//  valoEsports
//
//  Created by Designare Karthikey on 21/04/24.
//

import Foundation

struct Wrapper: Codable {
    let data: Data
}

struct LiveWrapper: Codable {
    let data: LiveData
}

struct UpcomingWrapper: Codable {
    let data: UpcomingData
}

struct Data: Codable {
    let status: Int
    let segments: [Result]
}

struct LiveData: Codable {
    let status: Int
    let segments: [LiveResult]
}

struct UpcomingData: Codable {
    let status: Int
    let segments: [UpcomingMatches]
}

struct Result: Codable {
    let team1: String
    let team2: String
    let score1: String
    let score2: String
    let flag1: String
    let flag2: String
    let tournament_name: String
    let tournament_icon: String
}

struct LiveResult: Codable {
    let team1: String
    let team2: String
    let score1: String
    let score2: String
    let flag1: String
    let flag2: String
    let match_event: String
}

struct UpcomingMatches: Codable {
    let team1: String
    let team2: String
    let flag1: String
    let flag2: String
    let match_event: String
    let time_until_match: String
}

func getMatchResults () async throws -> [Result] {
    let url = URL(string: "https://vlrggapi.vercel.app/match?q=results")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let wrapper = try JSONDecoder().decode(Wrapper.self, from: data)
    return wrapper.data.segments
}

func getLiveMatch () async throws -> [LiveResult] {
    let url = URL(string: "https://vlrggapi.vercel.app/match?q=live_score")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let wrapper = try JSONDecoder().decode(LiveWrapper.self, from: data)
    return wrapper.data.segments
}

func getUpcomingMatches () async throws -> [UpcomingMatches] {
    let url = URL(string: "https://vlrggapi.vercel.app/match?q=upcoming")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let wrapper = try JSONDecoder().decode(UpcomingWrapper.self, from: data)
    return wrapper.data.segments
}
