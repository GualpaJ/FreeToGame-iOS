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
    let short_description:String
    let genre:String
    let platform:String
    
    enum CodingKeys : String, CodingKey {
        case id, title, thumbnail,genre,platform
        case short_description = "short_description"
    }
    
}
