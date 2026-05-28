//
//  GameService.swift
//  FreeToGame
//
//  Created by Tardes on 28/5/26.
//
import Foundation

class GameService {
    static func getGameList() async -> [Game]{
        
        guard let url = URL(string: "https://www.freetogame.com/api/games") else {
            print ("Invalid URL")
            return []
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let result = try JSONDecoder().decode([Game].self, from: data)
            return result
        }catch {
            print ("Invalid data")
            return []
        }
    }
    
    static func getGameByID(_ id: Int) async -> Game? {
        
        guard let url = URL(string: "https://www.freetogame.com/api/game?id=\(id)") else {
            print ("Invalid URL")
            return nil
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let result = try JSONDecoder().decode(Game.self, from: data)
            return result
        }catch {
            print ("Invalid data")
            return nil
        }
    }
}
