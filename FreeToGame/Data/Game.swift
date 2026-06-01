//
//  Game.swift
//  FreeToGame
//
//  Created by Tardes on 28/5/26.
//

import Foundation

struct Game : Codable {
    let id:Int
    let title:String
    let thumbnail:String
    let shortDescription:String
    let genre:String
    let platform:String
    let developer:String
    let publisher:String
    let gameUrl: String
    let profileUrl: String
    let description: String?
    let systemRequirements: SystemRequirements?
    let screenshots: [Screenshot]?
    
    
    enum CodingKeys : String, CodingKey {
        case id, title, thumbnail,genre,platform, description, developer, publisher,screenshots
        case shortDescription = "short_description"
        case gameUrl = "game_url"
        case profileUrl = "freetogame_profile_url"
        case systemRequirements = "minimum_system_requirements"
    }
    
}

struct SystemRequirements : Codable {
    let os: String
    let processor: String
    let memory: String
    let graphics: String
    let storage: String
}

struct Screenshot : Codable {
    let image: String
}
