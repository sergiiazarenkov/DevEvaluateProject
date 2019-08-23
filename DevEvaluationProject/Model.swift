//
//  Model.swift
//  DevEvaluationProject
//
//  Created by user on 8/23/19.
//  Copyright © 2019 Azarenkov Serhii. All rights reserved.
//

import Foundation
class Model {
    private var items: [Item] = []
    private var page = 0
    
    func getItemsCount() -> Int {
        return items.count
    }
    
    func getItemForRow(row: Int) -> Item {
        return items[row]
        
    }
    
    func loadMore(callback:@escaping (String?, Bool) -> Void){
        APIManager.fetchItems(page: page) {[weak self] (unparcedArray, error) in
            guard let unparcedArray = unparcedArray
                else{
                    if let error = error {
                        callback(error, false)
                    } else {
                        callback("Error occured", false)
                    }
                    return
            }
            
            if unparcedArray.isEmpty{
                callback(nil, true)
                return
            }
            let newItems = Item.initFromArray(array: unparcedArray)
            
            self?.items += newItems
            self?.page += 1
            callback(nil, false)
            
        }
        
    }
    
}
