//
//  Datamodel.swift
//  Conscience
//
//  Created by Sophie Dixon on 21/10/2022.
//

import Foundation

class DataModel: ObservableObject {
    
    @Published var items: [Item] = []
    
    init() {
        if let documentDirectory = FileManager.default.documentDirectory {
            let urls = FileManager.default.getContentsOfDirectory(documentDirectory).filter { $0.isImage }
            for url in urls {
                let item = Item(url: url)
                items.append(item)
            }
        }
        
        if let urls = Bundle.main.urls(forResourcesWithExtension: "jpg", subdirectory: nil) {
            for url in urls {
                let item = Item(url: url)
                items.append(item)
            }
        }
    }
    
    func addItem(_ item: Item) {         //this adds an item to the collection
        items.insert(item, at: 0)
    }
    
            func removeItem(_ item: Item) {
                if let index = items.firstIndex(of: item) {
                    items.remove(at: index)
                    FileManager.default.removeItemFromDocumentDirectory(url: item.url)
                }
               
            }
        }
  
extension URL {
    var isImage: Bool {
        let imageExtensions = ["jpg", "jpeg", "heic"]
        return imageExtensions.contains(self.pathExtension)  
    }
}
