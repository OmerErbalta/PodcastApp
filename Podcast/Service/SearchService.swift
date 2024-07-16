//
//  SearchService.swift
//  Podcast
//
//  Created by OmerErbalta on 28.06.2024.
//

import Foundation
import Alamofire
class SearchService{
    static func fetchData(_ searchText:String,completion:@escaping([Podcast])->Void){
        let baseUrl = "https://itunes.apple.com/search"
        let parameters = ["media":"podcast","term":searchText]
        AF.request(baseUrl,parameters: parameters).responseData { response in
            if let error = response.error{
                print(error)
                return
            }
            guard let data = response.data else {return}
            do{
                let searchResult = try JSONDecoder().decode(Search.self, from: data)
                completion(searchResult.results)
            }catch{
                
            }
            
        }
    }
}
