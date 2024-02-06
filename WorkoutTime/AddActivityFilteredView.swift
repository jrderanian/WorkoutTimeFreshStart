//
//  AddActivityFilteredView.swift
//  WorkoutTime
//
//  Created by John Deranian on 2/5/24.
//

import SwiftUI


import SwiftUI

// This was great for learning how to add searchable to a view, note how the navigationStack is not here directly

struct AddActivityFilteredView: View {
    
    var exercises: [Exercise] // = Bundle.main.decode("exercises.json")
    @Binding var savedExercises: [Exercise]
    @Binding var homeNavigtionStack: [EnumNavigation]
    @State private var showingAlert = false
    @State private var unusedExercises = [Exercise]()
    //@Binding var searchText: String
    @State var searchText: String = ""
    
    var body: some View {
        //NavigationStack {
            VStack {
                Text("Total: \(exercises.count)")
                ScrollView {
                    LazyVStack {
                        ForEach(filteredExercises) { exercise in
                            NavigationLink(value: EnumNavigation.detailActivityView(exercise)) {
                                Text("\(exercise.name)")
                            }
                            .padding()
                        }
                        
                    }
                }
                .onAppear {
                    unusedExercises = updateUnsedExercises()
                    //filteredExercises = unusedExercises
                }
            }
            .searchable(text: $searchText)
                
        //}
    }
    
    func updateUnsedExercises() -> [Exercise] {
        
        return exercises.filter { item in
            savedExercises.contains { other in
                item.name == other.name
            } == false
        }
        
    }
    
    var filteredExercises: [Exercise] {
        guard !searchText.isEmpty else { return unusedExercises }
        return unusedExercises.filter { exercise in
            exercise.name.lowercased().contains(searchText.lowercased())
        }
    }
}

#Preview {
    let exercises: [Exercise]  = Bundle.main.decode("exercises.json")
    @State var path = NavigationPath()
    @State var savedExercises: [Exercise] = []
    @State var homeNavigationPath: [EnumNavigation] = []
    //@State var searchText = "Abs"
    
    return AddActivityFilteredView(exercises: exercises, savedExercises: $savedExercises, homeNavigtionStack: $homeNavigationPath)
    //AddActivityView()
}
