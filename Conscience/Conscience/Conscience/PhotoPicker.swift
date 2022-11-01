//
//  PhotoPicker.swift
//  Conscience
//
//  Created by Sophie Dixon on 29/10/2022.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {         //this is a view that displays Apple's photospicker
    @EnvironmentObject var dataModel: DataModel         //connects to data model, as images that are chosen have to be stored in datamodel of the app
    
    @Environment(\.dismiss) var dismiss 
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<PhotoPicker>) -> PHPickerViewController {
        
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        
        configuration.filter = .images
        //limiting the selection to images only
        configuration.preferredAssetRepresentationMode = .current
        
        let photoPickerViewController = PHPickerViewController(configuration: configuration)
        photoPickerViewController.delegate = context.coordinator
        return photoPickerViewController
    }
    
    func makeCoordinator() -> Coordinator {     //CREATES THE COORDINATOR THAT ALLOWS THE PICKER TO COMMUNICATE
        Coordinator(self)      
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: UIViewControllerRepresentableContext<PhotoPicker>) {
    }
}

class Coordinator: NSObject, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
    let parent: PhotoPicker
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        self.parent.dismiss()
        
        guard
            let result = results.first,
            result.itemProvider.hasItemConformingToTypeIdentifier(UTType.image.identifier)
        else { return }
        
        //load a file represenation of the picked item
        //this creates a temp file which is moved to the document directory for storage
        result.itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) {url, error in
            if let error = error {
                print("Error loading file representation: \(error.localizedDescription)")
            } else if let url = url {
                if let savedUrl = FileManager.default.copyItemToDocumentDirectory(from: url) {
                    // add the new item to the data model
                    Task { @MainActor [dataModel = self.parent.dataModel] in
                        withAnimation {
                            let item = Item(url: savedUrl)
                            dataModel.addItem(item)
                            
                        }
                    }
                }
            }
                
            }
        }
        init(_ parent: PhotoPicker) {
            self.parent = parent    
        }
    }
    

