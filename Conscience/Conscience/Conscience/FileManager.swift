//
//  FileManager.swift
//  Conscience
//
//  Created by Sophie Dixon on 21/10/2022.
//

import Foundation

extension FileManager {
    
    var documentDirectory: URL? {
        return self.urls(for: .documentDirectory, in: .userDomainMask).first        
    }
    func copyItemToDocumentDirectory(from sourceURL: URL) -> URL? { guard let documentDirectory = documentDirectory else { return nil }
        let fileName = sourceURL.lastPathComponent
        let destinationURL = documentDirectory.appendingPathComponent(fileName)
        if self.fileExists(atPath: destinationURL.path) {
            return destinationURL
        } else {
            do {
                try self.copyItem(at: sourceURL, to: destinationURL)
                return destinationURL
            } catch let error {
                print("unable to copy file: \(error.localizedDescription)")
            }
                
        }
        return nil
    }
    func removeItemFromDocumentDirectory(url: URL) {
        guard let documentDirectory = documentDirectory else { return }
        let fileName = url.lastPathComponent
        let fileUrl = documentDirectory.appendingPathComponent(fileName) 
        if self.fileExists(atPath: fileUrl.path) {
            do {
                try self.removeItem(at: url)
            } catch let error {
                print("unable to remove file: \(error.localizedDescription)")
                
            }
        }
        
    }
    func getContentsOfDirectory (_ url: URL) -> [URL] { //url must be a directory
        var isDirectory: ObjCBool = false
        guard FileManager.default.fileExists(atPath: url.path,isDirectory: &isDirectory), isDirectory.boolValue else { return []}
        do {
            return try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
        } catch let error {
            print("unable to get directory contents: \(error.localizedDescription)")
        }
        return []
    }
}
