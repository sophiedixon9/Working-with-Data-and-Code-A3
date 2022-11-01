//
//  DollarPerWear.swift
//  Conscience
//
//  Created by Sophie Dixon on 31/10/2022.
//

import SwiftUI

struct DollarPerWear: View {
    @State private var costItem = 0.0
    @State private var numberOfWears = 1
    
    var dollarPerWear: Double {
        //calculate the dollar per wear here
        let wearCount = Double(numberOfWears + 1)   //this bc you start at 1, it always says 2
        let dollarPerWear = costItem / wearCount
        
        return dollarPerWear            //this is the ultimate calculation for the dollar per wear 
    }
    
    var body: some View {
        NavigationView {    //this defines the view heirarchy
            Form {
                Section {
                    Text("Cost of item:")
                        .foregroundColor(.teal)
                    TextField("Amount", value: $costItem, format:       //textfield - user can inpt
                            .currency(code: "AUD"))
                    Picker("Number of wears", selection: $numberOfWears) {
                        ForEach(1..<100) { //this is arbitrary number
                            Text("\($0) wears")
                        }
                    }
                }
                
                Section {
                    Text("Dollar per wear equals:")
                        .foregroundColor(.teal)
                    
                    Text(dollarPerWear, format: .currency(code: "AUD"))
                    
                    
                }
            }
            
        }
        .navigationTitle("Your Hanger")
        
    }

    
    struct DollarPerWear_Previews: PreviewProvider {
        static var previews: some View {
            DollarPerWear().environmentObject(DataModel())
        }
    }
}


