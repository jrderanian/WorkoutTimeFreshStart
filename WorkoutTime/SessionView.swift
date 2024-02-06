//
//  SessionView.swift
//  WorkoutTime
//
//  Created by John Deranian on 2/2/24.
//

import SwiftUI

struct SessionView: View {
    var exercises: [Exercise]
    //@Binding var savedExercises: [Exercise]
    @Binding var homeNavigtionStack: [EnumNavigation]
    @Bindable var activityLogs: ActivityLogs
    //@Binding var checkedExercises: [CheckedExercises]
    @Bindable var checkedExercisesList: CheckedExercisesList
    //@State private var showSaveResults = false
    @State private var searchText = ""
    
    var body: some View {
        List {
            
            ForEach($activityLogs.records) { $record in
                let recordId =  record.id
                let thisExercise = exercises.first { $0.uuid == recordId} ?? Exercise.example
                
                Text("\(record.timeStamp) \(thisExercise.name) \(record.reps)")
            }
        }
    }
}

//#Preview {
//    SessionView()
//}
