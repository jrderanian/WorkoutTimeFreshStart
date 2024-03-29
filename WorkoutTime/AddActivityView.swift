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
    @State private var showingAlert = false
    @State private var unusedExercises = [Exercise]() // empty array of structs created here
    @State var searchText: String = ""
    
    var body: some View {
        VStack {
            Text("Total: \(exercises.count)")
            ScrollView {
                LazyVStack {
                    ForEach(filteredExercises, id:\.name) { exercise in
                        NavigationLink(value: EnumNavigation.detailActivityView(exercise)) {
                            Text("\(exercise.name)")
                        }
                        .padding()
                    }
                    
                }
            }
            .onAppear {
                unusedExercises = updateUnsedExercises()
            }
        }
        .searchable(text: $searchText, prompt: "Search for an Exercise")
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
    
    return AddActivityView(exercises: exercises, savedExercises: $savedExercises, homeNavigtionStack: $homeNavigationPath)
    //AddActivityView()
}
