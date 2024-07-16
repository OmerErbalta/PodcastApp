//
//  EpisodeCellViewModel.swift
//  Podcast
//
//  Created by OmerErbalta on 14.07.2024.
//

import Foundation

struct EpisodeCellViewModel{
    let episode:Episode!
    init(episode: Episode) {
        self.episode = episode
    }
    var profileImageUrl:URL?{
        return URL(string: episode.imageUrl)
    }
    var title:String?{
        return episode.title
    }
    var description:String?{
        return episode.description
    }
    var pubDate:String?{
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MMM dd, yyy"
        return dateFormater.string(from: episode.pubDate)
    }
    
}
