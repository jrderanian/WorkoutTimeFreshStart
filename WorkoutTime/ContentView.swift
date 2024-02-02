//
//  ContentView.swift
//  WorkoutTime
//
//  Created by John Deranian on 1/25/24.
//

import SwiftUI

enum EnumNavigation: Hashable {
    case addActivityView, detailActivityView(Exercise), sfsymbolView, loggingView
}

struct ContentView: View {
    
    var exercises: [Exercise] = Bundle.main.decode("exercises.json")
    //TODO: see how to save selections to json file...
    //search function, sort by musclegroup or difficulty,
    @State var homeNavigtionStack: [EnumNavigation] = []
    @State var savedExercises = [Exercise]()
    @State var activityLogs = ActivityLogs(records: [])
    //@State var checkedExercies: [CheckedExercises] = []
    @StateObject var checkedExercisesList = CheckedExercisesList(checkItems: [])
    
    
    
    var body: some View {
        
        NavigationStack(path: $homeNavigtionStack) {
            VStack {
                if (savedExercises.isEmpty){
                    Text("Welcome to Drano's app!")
                    Text("Hit the \(Image(systemName: "plus")) to Start!" )
                }
                ScrollView {
                    ForEach(savedExercises, id:\.name) { savedExercise in
                        
                        NavigationLink(value: EnumNavigation.detailActivityView(savedExercise)) {
                            Text(" View Detail \(savedExercise.name)")
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.footnote)
                    }
                }
            }
            .navigationDestination(for: EnumNavigation.self) { screen in
                switch screen {
                case .sfsymbolView: SfSymbolView()
                case .addActivityView: AddActivityView(exercises: exercises, savedExercises: $savedExercises, homeNavigtionStack: $homeNavigtionStack)
                case .detailActivityView(let Exercise): DetailActivityView(exercise: Exercise, savedExercises: $savedExercises, homeNavigtionStack: $homeNavigtionStack)
                case .loggingView: LoggingView(savedExercises: $savedExercises, homeNavigtionStack: $homeNavigtionStack, activityLogs: $activityLogs, checkedExercisesList: checkedExercisesList)
                }
            }
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    NavigationLink(value: EnumNavigation.sfsymbolView) {
                        Image(systemName: "apple.logo")
                            .resizable()
                            .frame(width: 18, height: 18)
                    }
                }
                ToolbarItem(placement: .automatic) {
                    NavigationLink(value: EnumNavigation.addActivityView) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 18, height: 18)
                    }
                }
                ToolbarItem(placement: .automatic) {
                    NavigationLink(value: EnumNavigation.loggingView) {
                        Image(systemName: "flame")
                            .resizable()
                            .frame(width: 18, height: 18)
                    }
                }
            }
        }
    }
    
}

#Preview {
    ContentView()
}
