//
//  LoggingView.swift
//  WorkoutTime
//
//  Created by John Deranian on 1/27/24.
//

import SwiftUI

extension Formatter {
    static let lucNumberFormat: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.minusSign   = "👺 "  // Just for fun!
        formatter.zeroSymbol  = ""     // Show empty string instead of zero
        return formatter
    }()
}


struct LoggingView: View {
    
    @Binding var savedExercises: [Exercise]
    @Binding var homeNavigtionStack: [EnumNavigation]
    @Bindable var activityLogs: ActivityLogs
    //@Binding var checkedExercises: [CheckedExercises]
    @Bindable var checkedExercisesList: CheckedExercisesList
    @State private var showSaveResults = false
    @State private var showingAlert = false
    
    
    
    //TODO:  Once all the items are checked, pop an alert and Log it.
    var body: some View {
        //let _ = Self._printChanges()
        if (savedExercises.isEmpty){
            Text("You haven't built a list of exercises")
            Text("Hit the \(Image(systemName: "plus")) to Start!" )
        }
        Form {
            
            ForEach($checkedExercisesList.checkItems) { $checkItem in
                
                Section("\(checkItem.Exercise.name)") {
                    
                    HStack {
                        Label("Weight", systemImage: "dumbbell.fill")
                        TextField("Weight", value: $checkItem.weight, formatter: .lucNumberFormat)
                            .keyboardType(.numberPad)
                            .clearButton(value: $checkItem.weight)
                    }
                    
                    HStack{
                        Label("Reps", systemImage: "repeat.circle.fill")
                        TextField("Reps", value: $checkItem.reps, formatter: .lucNumberFormat)
                            .keyboardType(.numberPad)
                            .clearButton(value: $checkItem.reps)
                    }
                }
            }
            Button("Save") {
                showingAlert = true
                showSaveResults = true
                saveLog(checkItems: checkedExercisesList)
               
            }
            .alert("Session Complete", isPresented: $showingAlert) {
                Button("OK", role: .cancel) {
                    homeNavigtionStack = []
                }
            } message: {
                Text("Session Recorded")
            }
            if showSaveResults {
                ForEach(activityLogs.records) { record in
                    Text("\(record.id)")
                }
                //Text("Saved")
            }
        }
        .onAppear{
            buildCheckBoxes()
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
                NavigationLink(value: EnumNavigation.addActivityView) {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 18, height: 18)
                }
            }
        }
    }
    func buildCheckBoxes() {
        for savedExercise in savedExercises {
            // does a CheckExercise already exist?
            let alreadyCheckedExcercise =  checkedExercisesList.checkItems
            let thisExercise = alreadyCheckedExcercise.filter({ $0.id == savedExercise.uuid})
            if thisExercise.isEmpty {
                let unchecked = CheckedExercises(uuid: savedExercise.uuid, Exercise: savedExercise, reps: 0, weight: 0)
                checkedExercisesList.checkItems.append(unchecked)
                //let _ = print("appending \(unchecked.id)") // nice way to print debug statments, this was key!
            }
        }
        // if in checkedExerciseList but no longer in saved, need to remove
        for checkedExercise in checkedExercisesList.checkItems {
            // if checkExercise is not in savedExcercises, remove
            if !savedExercises.contains(checkedExercise.Exercise) {
                if let idx = checkedExercisesList.checkItems.firstIndex(of: checkedExercise) {
                    checkedExercisesList.checkItems.remove(at: idx)
                }
            }
        }
    }
    
    func saveLog(checkItems: CheckedExercisesList) {
        
        let timeStamp = Date.now
        //let _ = print("\(timeStamp)")
        for checkItem in checkedExercisesList.checkItems {
            // create ActiivityLog and push onto ActivityLogs
            //let _ = print("\(checkItem.Exercise.name) \(timeStamp)")
            let activityLog = ActivityLog(exerciseId: checkItem.Exercise.uuid, timeStamp: timeStamp, reps: checkItem.reps, weight: checkItem.weight)
            // populate activityLogs
            activityLogs.records.append(activityLog)
            
        }
    }
}
