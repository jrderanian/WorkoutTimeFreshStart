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
    @ObservedObject var checkedExerciseList: CheckedExercisesList
    
    
    //TODO:  Once all the items are checked, pop an alert and Log it.
    var body: some View {
        if (savedExercises.isEmpty){
            Text("You haven't built a list of exercises")
            Text("Hit the \(Image(systemName: "plus")) to Start!" )
        }
        Form {
            
            
            
            //            //ForEach($checkedExercises, id:\.self) { $checkedExercise in
            ForEach($checkedExerciseList.checkItems) { $checkItem in
                //Section(header: Text("\(checkItem.Exercise.name)")) {
                Section("\(checkItem.Exercise.name)") {
                    HStack {
                        Text("W")
                        TextField("Wt", value: $checkItem.weight, formatter: NumberFormatter())
                        Text("R")
                        TextField("Reps", value: $checkItem.reps, formatter: NumberFormatter())
                        Text("T")
                        TextField("Time", value: $checkItem.duration, formatter: NumberFormatter())
                        Toggle(isOn: $checkItem.isChecked) {
                            Text("\(checkItem.Exercise.name)")
                            //.font(.system(.subheadline, design: .rounded))
                        }
                        .tint(.green)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.footnote)
                        
                        //.background(Color(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, opacity: 0.7))
                        //TextField("Reps", value: $checkItem.Exercise.reps, formatter: NumberFormatter())
                        //TextField(.constant(""), text: $checkItem.weight, placeholder: Text("weight"))
                        //   .padding(.all)
                    }
                    
                }
            }
        }
        .onAppear{
            //self.checkedExercises = buildCheckBoxes(savedExercises: savedExercises)
            //self.isChecked = buildCheckBoxes(isChecked: isChecked)
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
    //func buildCheckBoxes(savedExercises: [Exercise]) -> [CheckedExercises] {
    func buildCheckBoxes() {
        var checkedBoxes = [CheckedExercises]()
        for savedExercise in savedExercises {
            let unchecked = CheckedExercises(Exercise: savedExercise, isChecked: false)
            checkedBoxes.append(unchecked)
        }
        checkedExerciseList.checkItems = checkedBoxes
        // return checkedBoxes
    }
    
}






//                //                    TextField("Weight", value: $checkedExercise.weight, formatter: NumberFormatter())
//                //                    TextField("Reps", value: $checkedExercise.rep, formatter: NumberFormatter())
//                //TextField("Time in mins", value: self.$checkedExercise.duration, formatter: NumberFormatter())
//                VStack {
//                    HStack {
//                        TextField("Weight", value: $checkItem.weight, formatter: NumberFormatter())
//                        //                    TextField("Reps", value: $checkItem.reps, formatter: NumberFormatter())
//                        //                    TextField("Time in mins", value: $checkItem.duration, formatter: NumberFormatter())
//
//                    }
//                        Toggle(isOn: $checkItem.isChecked) {
//                            Text("\(checkItem.Exercise.name)")
//                            //.font(.system(.subheadline, design: .rounded))
//                        }
//                        .tint(.green)
//                        .padding()
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .font(.footnote)
//                    }
//                }
//            }
//        .onAppear{
//            //self.checkedExercises = buildCheckBoxes(savedExercises: savedExercises)
//            //self.isChecked = buildCheckBoxes(isChecked: isChecked)
//            buildCheckBoxes()
//        }


//        Button("Save Session"){
//            // create log entries,
//        }



//       }

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
