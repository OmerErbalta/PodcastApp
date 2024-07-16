//
//  SerchViewModel.swift
//  Podcast
//
//  Created by OmerErbalta on 9.07.2024.
//

import Foundation
struct SearchViewModel{
    let podcast:Podcast
    init(podcast: Podcast) {
        self.podcast = podcast
    }
    var photoImnageUrl:URL?{
        return URL(string: podcast.artworkUrl600 ?? "")
    }
    var trackCountString:String{
        return "\(podcast.trackCount ?? 0)"
    }
    var artistName:String{
        return "\(podcast.artistName ?? "Bilinmeyen Sanatcı")"
    }
    var trackName:String{
        return "\(podcast.trackName ?? "Bilinmeten Liste")"
    }
}
