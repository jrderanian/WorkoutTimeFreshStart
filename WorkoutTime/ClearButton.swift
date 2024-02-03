//
//  ClearButton.swift
//  WorkoutTime
//
//  Created by John Deranian on 1/31/24.
//

import Foundation
import SwiftUI

struct ClearButton: ViewModifier {
    @Binding var value: Int
    //@Binding var checked: Bool
    
    
    func body(content: Content) -> some View {
        //let _ = print("\(value) \(checked)")
        
        HStack {
            content
            if value > 0 {
                Button {
                    value = 0
                    //checked = false
                }label: {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 10)
            }
        }
    }
}

extension View {
    func clearButton(value: Binding<Int>) -> some View {
        modifier(ClearButton(value: value))
    }
}
