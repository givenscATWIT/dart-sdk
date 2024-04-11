import 'package:workouttutorial/models/exercise.dart';
import '../models/workout.dart';

class WorkoutData extends ChangeNotifier {
  final db = HiveDatabase();

  /*

    WORKOUT DATA STRUCTURE

    - This overall list contains different workouts
    - each workout has a name, and list of exercises

  */

  List<Workout> workoutList = [
    // default workout
    Workout(
      name: "Upper Body",
      exercise: [
        Exercise(
          name: "Bicep Curls",
          weight: "10",
          reps: "10",
          sets: "3",
        ), // Exercise
      ],
    ) // Workout
    Workout(
      name: "Lower Body",
      exercise: [
        Exercise(
          name: "Squats",
          weight: "10",
          reps: "10",
          sets: "3",
        ), // Exercise
      ],
    ) // Workout
  ];

  // if there are workouts already in database, then get that workout list

  void initalizedWorkoutList() {
    if (db.previousDataExist()) {
      workoutList = db.readFromDatabase();
    }

  // otherwise use the default workouts
    else {
      db.saveToDatabase(workoutList);
    }

    // load heat map
    loadHeatMap();
  }

  // get the list of workouts
  List<Workout> getWorkoutList() {
    return workoutList;
  }

  // get length of a given workout
  int numberOfExercisesInWorkout(String workoutName) {
    Workout releventWorkout = getReleventWorkout(workoutName);

    return releventWorkout.exercise.length;
  }

  // add a workout
  void addWorkout(String name) {
    // add a new workout with a blank list of exercises
    workoutList.add(Workout(name: name, exercise: []));

    notifyListeners();
    // save to database
    db.saveToDatabase(workoutList);
  }

  // add an exercise to a workout
  void addExercise(String workoutName, String exerciseName, String weight, String reps, String sets) {
    // find the relevent workout
    Workout releventWorkout = getReleventWorkout(workoutName);

    releventWorkout.exercises.add(
      Exercise(
        name: exerciseName,
        weight: weight, 
        reps: reps,
        sets: sets
      )
    );

    notifyListeners();
    // save to database
    db.saveToDatabase(workoutList);
  }

  // check off exercise
  void checkOffExercise(String workoutName, String exerciseName){
    // find the relevent workout and relevent exercise in that workout
    Exercise releventExercise = getReleventExercise(workoutName, exerciseName);

    // check off boolean to show user completed the exercise
    releventExercise.isCompleted = !releventExercise.isCompleted;

    notifyListeners();
    // save to database
    db.saveToDatabase(workoutList);
    // load heat map
    loadHeatMap();
  }

  // return relevent workout object, given a workout name
  Workout getReleventWorkout(String workoutName) {
    Workout releventWorkout = workoutList.firstWhere((workout) => workout.name == workoutName);

    return releventWorkout;
  }

  // return relevent exercise object, given a workout name + exercise name
  Exercise getReleventExercise(String workoutName, String exerciseName) {
    // find relevent workout first
    Workout releventWorkout = getReleventWorkout(workoutName);

    // then find the relevent exercise in that workout
    Exercise getReleventExercise = releventWorkout.exercise.firstWhere((exercise) => exercise.name == exerciseName);

    return releventExercise;
  }

  // get start date
  String getStartDate() {
    return db.getStartDate();
  }

  /*

    HEAT MAP

  */

  Map<DateTime, int> heatMapDataSet = {};

  void loadHeatMap() {
    DateTime startDate = createDateTimeObject(getStartDate());

    // count the number of days to load
    int daysInBetween = DateTime.now().difference(startDate).inDays;

    // go from start date to today, and add each completion status to the dataset
    //"COMPLETION_STATUS_yyyymmdd" will be the key in the dataset
    for (int i=0; i<daysInBetween+1; i++){
      String yyyymmdd = convertDateTimeToYYYYMMDD(startDate.add(Duration(days: i)));

      // completion status 0 or 1
      int completionStatus = db.getCompletionStatus(yyyymmdd);

      //year
      int year = startDate.add(Duration(days: i)).year;

      //month
      int month = startDate.add(Duration(days: i)).month;

      //day
      int day = startDate.add(Duration(days: i)).day;

      final percentForEchDay = <DateTime, int> {
        DateTime(year, month, day): completionStatus;
      };

      // add to the heat mapp dataset
      heatMapDataSet.addEntries(percentForEchDay.entries);

    }
  }
}

