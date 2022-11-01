//
//  PhotoView.swift
//  Conscience
//
//  Created by Sophie Dixon on 30/10/2022.
//

import SwiftUI

struct PhotoView: View {
    let size: Double                
    let item: Item
    
    var body: some View {
        VStack {
            
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: item.url) {image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: size, height: size)
            }

        }
        }
    }
struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        if let url = Bundle.main.url(forResource: "mushy1", withExtension: "jpg") {
            PhotoView(size: 50, item: Item(url: url))
        }
    }
}

