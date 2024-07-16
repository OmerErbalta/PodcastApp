//
//  EpisoodeService.swift
//  Podcast
//
//  Created by OmerErbalta on 9.07.2024.
//

import Foundation
import FeedKit
import Alamofire
struct EpisoodeService{
    static func fetchData(_ urlString:String,compliton:@escaping([Episode])-> Void){
        var episodeResult:[Episode] = []
        let feedKit = FeedParser(URL: URL(string: urlString)!)
        feedKit.parseAsync { result in
            switch result {
            case .success(let feed):
                switch feed{
                    
                case .atom(_):
                    break
                case .rss(let feedResult):
                    feedResult.items?.forEach({ value in
                        let episodeCell = Episode(value)
                        episodeResult.append(episodeCell)
                        compliton(episodeResult)
                    })
                case .json(_):
                    break
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    static func downloadEpisode(episode:Episode){
        let downloadRequest = DownloadRequest.suggestedDownloadDestination()
        AF.download(episode.streamUrl,to: downloadRequest).downloadProgress{ progress in
            let progressValue = progress.fractionCompleted
            NotificationCenter.default.post(name: .downloadNotificationName, object: nil,userInfo: ["title":episode.title,"progress":progressValue])
            
        }.response{ response in
            var downloadEpisodeResponse = UserDefaults.downloadEpisodeRead()
            let index = downloadEpisodeResponse.firstIndex(where: {$0.author == episode.author && $0.streamUrl ==  episode.streamUrl})
            downloadEpisodeResponse[index!].fileUrl = response.fileURL?.absoluteString
            do{
                let data = try JSONEncoder().encode(downloadEpisodeResponse)
                UserDefaults.standard.set(data, forKey: UserDefaults.downloadKey)
            }catch{
                
            }
        }
    }
}
