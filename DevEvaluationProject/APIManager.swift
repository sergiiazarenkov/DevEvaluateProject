//
//  APIManager.swift
//  DevEvaluationProject
//
//  Created by user on 8/14/19.
//  Copyright © 2019 Azarenkov Serhii. All rights reserved.
//

import UIKit

class APIManager {
    static func fetchItems(page: Int, completion:@escaping ([Any]?, String?) -> Void){
        guard let url = URL(string: "https://hn.algolia.com/api/v1/search_by_date?tags=story&page=\(page)") else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        DispatchQueue.global(qos: .utility).async {
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                DispatchQueue.main.async {
                    
                    guard let data = data else{
                        if let error = error {
                            completion(nil ,error.localizedDescription)
                        } else{
                            completion(nil, "Unable to fetch data")
                        }
                        return
                    }
                    
                    do{
                        if let dict = try  JSONSerialization.jsonObject(with: data, options: []) as? [String:Any],
                            let arr = dict["hits"] as? [Any]?{
                            completion(arr, nil)
                        } else{
                            completion(nil, "Unable to parce data")
                        }
                    } catch let error{
                        completion(nil, error.localizedDescription)
                        
                    }
                }
                
                }.resume()
        }
    }
    
}
