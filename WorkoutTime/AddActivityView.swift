//
//  AddActivityView.swift
//  WorkoutTime
//
//  Created by John Deranian on 1/26/24.
//

import SwiftUI

struct AddActivityView: View {
    
    var exercises: [Exercise] // = Bundle.main.decode("exercises.json")
    @Binding var savedExercises: [Exercise]
    @Binding var homeNavigtionStack: [EnumNavigation]
    //TODO: create detail view of excercise
    //@Binding var path: NavigationPath
    @State private var showingAlert = false
    @State private var unusedExercises = [Exercise]() // empty array of structs created here
    
    
    
    var body: some View {
        VStack {
            Text("Total: \(exercises.count)")
            ScrollView {
                
                ForEach(unusedExercises, id:\.name) { exercise in
                    NavigationLink(value: EnumNavigation.detailActivityView(exercise)) {
                        Text("\(exercise.name)")
                    }
                    .padding()
                }
                .onAppear {
                    unusedExercises = updateUnsedExercises()
                }
            }
        }
    }
    
    func updateUnsedExercises() -> [Exercise] {
        
        return exercises.filter { item in
            savedExercises.contains { other in
                item.name == other.name
            } == false
        }
        
    }
}

#Preview {
    let exercises: [Exercise]  = Bundle.main.decode("exercises.json")
    @State var path = NavigationPath()
    @State var savedExercises: [Exercise] = []
    @State var homeNavigationPath: [EnumNavigation] = []
    
    return AddActivityView(exercises: exercises, savedExercises: $savedExercises, homeNavigtionStack: $homeNavigationPath)
    //AddActivityView()
}
