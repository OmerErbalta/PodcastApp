//
//  Episode.swift
//  Podcast
//
//  Created by OmerErbalta on 14.07.2024.
//

import Foundation
import FeedKit
struct Episode:Codable{
    let title:String
    let pubDate:Date
    let description:String
    let imageUrl:String
    let streamUrl:String
    let author:String
    var fileUrl:String?
    init(_ value:RSSFeedItem) {
        self.title = value.title ?? ""
        self.pubDate = value.pubDate ?? Date()
        self.description = value.iTunes?.iTunesSubtitle ?? value.description ?? ""
        self.imageUrl = value.iTunes?.iTunesImage?.attributes?.href ?? "https://cdn-icons-png.freepik.com/512/1312/1312585.png"
        self.streamUrl = value.enclosure?.attributes?.url ?? "" 
        self.author = value.iTunes?.iTunesAuthor ?? value.author ?? ""
    }
}
