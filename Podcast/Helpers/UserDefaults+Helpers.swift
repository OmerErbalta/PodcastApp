//
//  UserDefaults+Helpers.swift
//  Podcast
//
//  Created by OmerErbalta on 15.07.2024.
//

import Foundation
extension UserDefaults{
    static let downloadKey = "downloadKey"
    static func downloadEpisodeWrite(episode:Episode){
        do{
            var resultEpisodes = downloadEpisodeRead()
            resultEpisodes.append(episode)
            let data = try JSONEncoder().encode(resultEpisodes)
            UserDefaults.standard.setValue(data, forKey: UserDefaults.downloadKey)
        }catch{
            
        }
    }
    static func downloadEpisodeRead()->[Episode]{
        guard let data = UserDefaults.standard.data(forKey: UserDefaults.downloadKey) else {return []}
        do{
            let resultData = try JSONDecoder().decode([Episode].self, from: data)
            return resultData
        }catch{
            
        }
        return []
    }
}
