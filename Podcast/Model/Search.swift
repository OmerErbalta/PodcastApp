//
//  Search.swift
//  Podcast
//
//  Created by OmerErbalta on 28.06.2024.
//

import Foundation
struct Search:Decodable{
    let resultCount:Int
    let results:[Podcast]
}
struct Podcast:Decodable{
    var trackName:String?
    var artistName:String?
    var trackCount:Int?
    var artworkUrl600:String?
    var feedUrl:String?
    
}
