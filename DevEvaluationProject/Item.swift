//
//  Item.swift
//  DevEvaluationProject
//
//  Created by user on 8/14/19.
//  Copyright © 2019 Azarenkov Serhii. All rights reserved.
//

import Foundation
struct Item {
    
    let postTitle: String
    let createdAt: String
    init(postTitle: String, createdAt: String) {
        self.postTitle = postTitle
        self.createdAt = createdAt
    }
    
    static func initFromArray(array: [Any]) -> [Item]{
        var items = [Item]()
        for dict in array{
            guard let dict = dict as? [String: Any],
                let title = dict["title"] as? String,
            let created = dict["created_at"] as? String
                else{continue}
            let item = Item(postTitle: title, createdAt: created)
            items.append(item)
            
        }
        return items
    }
}
