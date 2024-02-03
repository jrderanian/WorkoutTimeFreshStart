//
//  Exercise.swift
//  WorkoutTime
//
//  Created by John Deranian on 1/25/24.
//

import Foundation



@Observable
class ActivityLog: Identifiable, Codable {
    
    var id: UUID // id of exercise
    var exerciseId: UUID
    var timeStamp: Date
    var reps: Int
    var weight: Int
    //var exercise: Exercise
    
    init(exerciseId: UUID, timeStamp: Date, reps: Int, weight: Int) {
        self.id = UUID()
        self.exerciseId = exerciseId
        self.timeStamp = Date.now
        self.reps = reps
        self.weight = weight
        //self.exercise = exercise
    }
    
}

@Observable
class ActivityLogs {
    
    var records = [ActivityLog]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(records){
                UserDefaults.standard.setValue(encoded, forKey: "ActivityLogs")
                let _ = print("Got here")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "ActivityLogs") {
            if let decodedItems = try? JSONDecoder().decode([ActivityLog].self, from: savedItems) {
                records = decodedItems
                return
            }
        }

        records = []
    }
    
    func zeroOut() {
        
        UserDefaults.standard.removeObject(forKey: "ActivityLogs")
        UserDefaults.standard.synchronize()
        
    }
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            //let _ = print("\(key)")
            defaults.removeObject(forKey: key)
        }
        records.removeAll()
    }
    
}

@Observable
class CheckedExercisesList {
    var checkItems: [CheckedExercises]
    
    init(checkItems: [CheckedExercises]) {
        self.checkItems = checkItems
    }
}

struct CheckedExercises: Codable, Hashable, Identifiable {
    // MARK: I only need the uuid of the exercise, because it's permanent in the  exercieses.json file
    var id = UUID()
    var Exercise: Exercise
    //var isChecked: Bool = false
    var reps: Int = 0
    //var duration: Int = 0 // minutes
    var weight: Int = 0 // lbs for now, we could go crazy with this.
    
    
}

extension CheckedExercises {
    
    init(uuid: UUID, Exercise: Exercise, reps: Int, weight: Int) {
        self.id = Exercise.uuid
        self.Exercise = Exercise
        //self.isChecked = isChecked
        self.reps = reps
        self.weight = weight
    }
    
}

struct Exercise: Codable, Hashable {
    var uuid = UUID()
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
    
    
    static let example = Exercise(name: "Sitting", force: "none", level: "Beginner", mechanic: "none", equipment: "chair", primaryMuscles: ["Face"], secondaryMuscles: ["Nose"], instructions: ["SWeat"], category: "Running")
    
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
