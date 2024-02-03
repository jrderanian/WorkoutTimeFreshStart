//
//  DetailActivityView.swift
//  WorkoutTime
//
//  Created by John Deranian on 1/26/24.
//

import SwiftUI

struct DetailActivityView: View {
    
    var exercise: Exercise
    //@Binding var path: EnumNavigation
    @Binding var savedExercises: [Exercise]
    @Binding var homeNavigtionStack: [EnumNavigation]
    //@State private var showAddButton = true
    
    var body: some View {
        Form {
            Text("Name: \(exercise.name)")
            Text("Force: \(exercise.displayedForce)")
            Text("Level: \(exercise.level)")
            Text("Equipment: \(exercise.displayedEquipment)")
            Section("Instructions") {
                ForEach(exercise.instructions, id:\.self) { instruction in
                    Text("\(instruction)")
                }
            }
            ForEach(exercise.primaryMuscles, id:\.self) { primaryMuscle in
                Text("Primary Muscle Groups: \(primaryMuscle)")
            }
            ForEach(exercise.secondaryMuscles, id:\.self) { secondaryMuscle in
                Text("Primary Muscle Groups: \(secondaryMuscle)")
            }
            
            //Text("\(exercise.instructions)")
            Text("\(exercise.category)")
            
            
        }
        .toolbar {
//            ToolbarItem(placement: .automatic) {
//                NavigationLink(value: EnumNavigation.sfsymbolView) {
//                    Image(systemName: "apple.logo")
//                        .resizable()
//                        .frame(width: 18, height: 18)
//                }
//            }
            ToolbarItem(placement: .automatic) {
                if savedExercises.contains(exercise) {
                    Button("\(Image(systemName: "trash"))")  {
                        //exercise.putOnList()
                        if let idx = savedExercises.firstIndex(of: exercise) {
                            savedExercises.remove(at: idx)
                        }
                        homeNavigtionStack = []
                    }
                } else {
                    Button("\(Image(systemName: "plus"))") {
                        //exercise.putOnList()
                        savedExercises.append(exercise)
                        homeNavigtionStack = []
                    }
//                    Button(role: .destructive, action: {activityLogs.resetDefaults()}) {
//                            Label("Remove", systemImage: "trash")
//                        }
                }
            }
        }
    }
    
  
}

#Preview {
    @State var exercises: [Exercise] = Bundle.main.decode("exercises.json")
    @State var path = NavigationPath()
    @State var savedExercises: [Exercise] = []
    @State var homeNavigationPath: [EnumNavigation] = []
    
    
    return DetailActivityView(exercise: exercises[0], savedExercises: $savedExercises, homeNavigtionStack: $homeNavigationPath)
}
