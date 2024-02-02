//
//  LoggingView.swift
//  WorkoutTime
//
//  Created by John Deranian on 1/27/24.
//

import SwiftUI



struct LoggingView: View {
    
    @Binding var savedExercises: [Exercise]
    @Binding var homeNavigtionStack: [EnumNavigation]
    @Binding var activityLogs: ActivityLogs
    //@Binding var checkedExercises: [CheckedExercises]
    @ObservedObject var checkedExercisesList: CheckedExercisesList
    @State private var showSaveResults = false
    
    
    //TODO:  Once all the items are checked, pop an alert and Log it.
    var body: some View {
        if (savedExercises.isEmpty){
            Text("You haven't built a list of exercises")
            Text("Hit the \(Image(systemName: "plus")) to Start!" )
        }
        Form {
            ForEach($checkedExercisesList.checkItems) { $checkItem in
                
                Section("\(checkItem.Exercise.name)") {
                    HStack {
                        Label("Weight", systemImage: "dumbbell.fill")
                        TextField("Weight", value: $checkItem.weight, format: .number)
                            .clearButton(value: $checkItem.weight, checked: $checkItem.isChecked)
                    }
                    HStack{
                        Label("Reps", systemImage: "repeat.circle.fill")
                        TextField("Reps", value: $checkItem.reps, formatter: NumberFormatter())
                            .clearButton(value: $checkItem.reps, checked: $checkItem.isChecked)
                    }
                    
                    
                    
                    Toggle(isOn: $checkItem.isChecked) {
                        Text("\(checkItem.Exercise.name)")
                        //.font(.system(.subheadline, design: .rounded))
                    }
                }
            }
            Button("Save") {
                // grey until all items are toggled
                saveLog(checkItems: checkedExercisesList)
                showSaveResults.toggle()
            }
            if showSaveResults {
                ForEach($activityLogs.records) { record in
                    Text("\(record.id)")
                }
                //Text("Saved")
            }
        }
        .onAppear{
            buildCheckBoxes()
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
        }
    }
    func buildCheckBoxes() {
        for savedExercise in savedExercises {
            // does a CheckExercise already exist?
            let alreadyCheckedExcercise =  checkedExercisesList.checkItems
            let thisExercise = alreadyCheckedExcercise.filter({ $0.id == savedExercise.uuid})
            if thisExercise.isEmpty {
                let unchecked = CheckedExercises(uuid: savedExercise.uuid, Exercise: savedExercise, isChecked: false, reps: 0, weight: 0)
                checkedExercisesList.checkItems.append(unchecked)
                //let _ = print("appending \(unchecked.id)") // nice way to print debug statments, this was key!
            }
        }
    }
    
    func saveLog(checkItems: CheckedExercisesList) {
        
        let timeStamp = Date.now
        for checkItem in checkedExercisesList.checkItems {
            // create ActiivityLog and push onto ActivityLogs
            let activityLog = ActivityLog(id: checkItem.Exercise.uuid, timeStamp: timeStamp, reps: checkItem.reps, weight: checkItem.weight)
            // populate activityLogs
            activityLogs.records.append(activityLog)
            
        }
        
        //MARK:  Write the records somewhere...
        
    }
    
}






//#Preview {
//
//    //let exercises: [Exercise]  = Bundle.main.decode("exercises.json")
//    @State var path = NavigationPath()
//    @State var savedExercises: [Exercise] = []
//    @State var homeNavigationPath: [EnumNavigation] = []
//    @State var activityLogs = ActivityLogs(records: [])
//    //@State var checkedExercises: [CheckedExercises] = []
//    var checkedExerciseList: CheckedExercisesList
//
//
//    //return LoggingView(savedExercises: $savedExercises, homeNavigtionStack: $homeNavigationPath, activityLogs: $activityLogs, checkedExercises: $checkedExercises)
//    return LoggingView(savedExercises: $savedExercises, homeNavigtionStack: $homeNavigationPath, activityLogs: $activityLogs, checkedExerciseList: checkedExerciseList)
//}
