//
//  SfSymbolView.swift
//  WorkoutTime
//
//  Created by John Deranian on 1/26/24.
//

import SwiftUI

struct SfSymbolView: View {
    
    let layout = [
        GridItem(.adaptive(minimum: 30)),
    ]
    
    @State private var selectedSymbol = "apple.logo"
    
    var body: some View {
        VStack {
            Text("Picked \(Image(systemName: selectedSymbol))")
            ScrollView(.vertical) {
                LazyVGrid(columns: layout) {
                    ForEach(symbols, id:\.self) {symbol in
                        
                        Button {
                            selectedSymbol = symbol
                        } label: {
                            Image(systemName: symbol)
                                .symbolRenderingMode(.hierarchical)
                                .foregroundColor(.indigo)
                        }
                    }
                    
                }
                
                
            }
        }
        
    }
}

#Preview {
    SfSymbolView()
}
