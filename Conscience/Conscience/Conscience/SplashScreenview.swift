//
//  SplashScreenview.swift
//  Conscience
//
//  Created by Sophie Dixon on 18/10/2022.
//

import SwiftUI

struct SplashScreenview: View {
    @State private var isActive = false
    @State private var size = 0.5
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            PhotoGridView()
        } else {
            VStack {
                VStack {
                    Image (systemName: "leaf.fill")
                        .font(.system(size: 100))
                        .foregroundColor(Color(hue: 0.503, saturation: 0.361, brightness: 0.841))
                    Text ("Conscience")
                        .font(Font.custom("Baskerville", size : 30))
                        .foregroundColor(.black.opacity(0.90))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear { withAnimation(.easeIn (duration: 3)) {
                    self.size = 1.0
                    self.opacity = 1.0
                    
                }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {self.isActive = true }
                }
            }
        }
    }
    
    struct SplashScreenview_Previews: PreviewProvider {
        static var previews: some View {
            SplashScreenview()
        }
    }
}
