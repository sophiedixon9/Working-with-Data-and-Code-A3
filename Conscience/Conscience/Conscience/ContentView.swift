//
//  ContentView.swift
//  Conscience
//
//  Created by Sophie Dixon on 18/10/2022.
//

import SwiftUI

struct PhotoGridView: View { 
    @EnvironmentObject var dataModel: DataModel
    
    private static let numberColumns = 3     //this is a binding value of columns
    @State private var isAddingPhoto = false
    @State private var isEditing = false    //boolean values
    @State private var gridColumns = Array(repeating:GridItem(.flexible()), count: numberColumns)
    
    private var columnsTitle: String {
        gridColumns.count > 1 ? "\(gridColumns.count) Columns" : "1 Column"
        
    }
    
    var body: some View {
        VStack{
            
            ScrollView {
                LazyVGrid(columns: gridColumns) {
                    ForEach(dataModel.items) { item in
                        GeometryReader { geo in
                            NavigationLink (destination: DetailView(item: item)) {
                                PhotoView(size: geo.size.width, item: item)
                                
                            }
                        }
                        .cornerRadius(8)        //originally i just had the geometryreader and lazygrid, but they all came and laid on top of each other. i had to add aspect ratios, and radius to keep it confined and inline
                        .aspectRatio(1, contentMode: .fit)
                        .overlay(alignment: .topTrailing) {
                            if isEditing {
                                Button {
                                    withAnimation {
                                        dataModel.removeItem(item)
                                    }
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(Font.title)
                                        .symbolRenderingMode(.palette)
                                        .foregroundStyle(.white, .red)
                                }
                                
                            }
                        }
                    }
                }

                .padding()
                
            }
            
        }
        .navigationBarTitle("Your Wardrobe")        //below this is the navigation bar organiing 
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isAddingPhoto) {
            PhotoPicker()
              
        }
        .toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {     //originally i just had an add button, until i was trialing, through using the simulator and couldn't remove any + they were originally accidentally layered on top of each other
                Button(isEditing ? "Done" : "Edit") {
                    withAnimation { isEditing.toggle() }
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isAddingPhoto = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct PhotoGridView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoGridView().environmentObject(DataModel())
    }
}
