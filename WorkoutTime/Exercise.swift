//
//  Exercise.swift
//  WorkoutTime
//
//  Created by John Deranian on 1/25/24.
//

import Foundation



@Observable
class ActivityLog: Identifiable {
    
    var id: UUID // id of exercise
    var timeStamp: Date
    var reps: Int
    var weight: Int
    //var exercise: Exercise
    
    init(id: UUID, timeStamp: Date, reps: Int, weight: Int) {
        self.id = id
        self.timeStamp = Date.now
        self.reps = reps
        self.weight = weight
        //self.exercise = exercise
    }
    
}

@Observable
class ActivityLogs: Identifiable {
    var records:[ActivityLog]
    
    init(records: [ActivityLog]) {
        // eventually pull these from a datastore somewhere
        self.records = []
    }
    
}

class CheckedExercisesList: ObservableObject {
    @Published var checkItems: [CheckedExercises]
    
    init(checkItems: [CheckedExercises]) {
        self.checkItems = checkItems
    }
}

struct CheckedExercises: Codable, Hashable, Identifiable {
    // MARK: I only need the uuid of the exercise, because it's permanent in the  exercieses.json file
    var id = UUID()
    var Exercise: Exercise
    var isChecked: Bool = false
    var reps: Int = 0
    //var duration: Int = 0 // minutes
    var weight: Int = 0 // lbs for now, we could go crazy with this.
    
    
}

extension CheckedExercises {
    
    init(uuid: UUID, Exercise: Exercise, isChecked: Bool, reps: Int, weight: Int) {
        self.id = Exercise.uuid
        self.Exercise = Exercise
        self.isChecked = isChecked
        self.reps = reps
        self.weight = weight
    }
    
}

struct Exercise: Codable, Hashable {
    let uuid: UUID
    var name: String
    let force: String?
    let level: String
    let mechanic: String?
    let equipment: String?
    let primaryMuscles: [String]
    let secondaryMuscles: [String]
    let instructions: [String]
    let category: String
    
    var displayedForce: String {
        force ?? "n/a"
    }
    
    var displayedMechanic: String {
        mechanic ?? "none"
    }
    
    var displayedEquipment: String {
        equipment ?? "none"
    }
    
}

//{
//  "name": "3/4 Sit-Up",
//  "force": "pull",
//  "level": "beginner",
//  "mechanic": "compound",
//  "equipment": "body only",
//  "primaryMuscles": [
//    "abdominals"
//  ],
//  "secondaryMuscles": [],
//  "instructions": [
//    "Lie down on the floor and secure your feet. Your legs should be bent at the knees.",
//    "Place your hands behind or to the side of your head. You will begin with your back on the ground. This will be your starting position.",
//    "Flex your hips and spine to raise your torso toward your knees.",
//    "At the top of the contraction your torso should be perpendicular to the ground. Reverse the motion, going only Â¾ of the way down.",
//    "Repeat for the recommended amount of repetitions."
//  ],
//  "category": "strength"
//},
