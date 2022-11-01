//
//  Item.swift
//  Conscience
//
//  Created by Sophie Dixon on 21/10/2022.
//

import SwiftUI

struct Item: Identifiable {         //for each item to be stored it has to be assigned an id, so it can be retrieved
    
    let id = UUID()
    let url: URL
    
}

extension Item: Equatable {
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id && lhs.id == rhs.id
    }
}
