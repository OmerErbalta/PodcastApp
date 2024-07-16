//
//  FavoriteCellViewModel.swift
//  Podcast
//
//  Created by OmerErbalta on 15.07.2024.
//

import Foundation
struct FavoriteCellViewModel{
    var podcastCoreData:PodcastCoreData!
    init(podcastCoreData:PodcastCoreData) {
        self.podcastCoreData = podcastCoreData
    }
    var podcastImageUrl:URL?{
        return URL(string: podcastCoreData.artworkUrl600!)
    }
    var podcastName:String{
        return podcastCoreData.trackName ?? ""
    }
    var podcastArtistName:String{
        return podcastCoreData.artistName ?? ""
    }
}
