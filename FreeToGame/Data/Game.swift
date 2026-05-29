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
    let description: String?
    
    
    enum CodingKeys : String, CodingKey {
        case id, title, thumbnail,genre,platform, description, developer, publisher
        case shortDescription = "short_description"
    }
    
}
