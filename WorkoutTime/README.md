#  WorkOutTime

Next Steps:

I have the data to be logged here:

class ActivityLog: Identifiable {
    var id: UUID // id of exercise
    var timeStamp: Date
    var reps: Int
    var weight: Int
}

Now to write somewhere and then read on startup to pre-populate savedExercises

AddActivityView needs filters, search engine by name, difficulty, maybe muscle groups

Bonus: create another view to show all records.
