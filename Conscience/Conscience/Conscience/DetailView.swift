//
//  DetailView.swift
//  Conscience
//
//  Created by Sophie Dixon on 30/10/2022.
//

import SwiftUI

struct DetailView: View {
    let item: Item
    
    var body: some View {
        VStack {
            AsyncImage(url: item.url) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            DollarPerWear()
            
            
        }
    }
    struct ImageView_Previews: PreviewProvider  {
        static var previews: some View {
            if let url = Bundle.main.url(forResource: "mushy1", withExtension: "jpg") { 
                DetailView(item: Item(url: url))
                
                
            }
        }
    }
}
