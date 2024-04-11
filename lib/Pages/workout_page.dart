import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workouttutorial/data/workout_data.dart';

class WorkoutPage extends StatefulWidget {
  final String workoutName;
  const WorkoutPage({super.key, required this.workoutName});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState;
}

class _WorkoutPageState extends State<WorkoutPage> {

  // checkbox was tapped
  void onCheckBoxChanged(String workoutName, String exerciseName){
    Provider.of<WorkoutData>(context, listen: false)
      .checkOffExercise(workoutName, exerciseName);
  }

  // text controllers
  final exerciseNameController = TextEditingController();
  final weightController = TextEditingController();
  final repsController = TextEditingController();
  final setsController = TextEditingController();

  // create a new exercise
  void createNewExercise() {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text('Add a new exercise'),
        content: Column(
          mainAxisSize: mainAxisSize.min,
          children: [
            //exercise name
            TextField(
              controller: exerciseNameController,
            ), // TextField

            // weigth
            TextField(
              controller: weightController,
            ), // TextField

            // reps
            TextField(
              controller: repsController,
            ), // TextField

            //sets
            TextField(
              controller: setsController,
            ), // TextField
          ]
        )
        actions: [
          // save button
          MaterialButton(
            onPressed: save,
            child: Text("save"),
          ), // MaterialButton

          // cancel button
          MaterialButton(
            onPressed: cancel,
            child: Text("cancel"),
          ), // MaterialButton
        ]
      ), // AlertDialog
    ); // showDialog
  }

  // save workout
  void save() {
    // get exercise name from text controller
    String newExerciseName = newExerciseNameController.text;
    String weight = weightController.text,
    String reps = repsController.text,
    String sets = setsController.text,
    // add exercise to workout
    Provider.of<WorkoutData>(context, listen: false).addWorkout(
      widget.WorkoutName,
      newExerciseName,
      weight,
      reps,
      sets,
    );

    // pop dialog box
    Navigator.pop(context);
    clear();
  }

  // cancel
    void cancel() {
      // pop dialog box
      Navigator.pop(context);
      clear();    
  }

  // clear controllers
  void clear() {
    exerciseNameController.clear();
    weightController.clear();
    repsController.clear();
    setsController.clear();
  }

  @override
  Widget build(BuildContext: context){
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scafold(
        appBar: AppBar(title: Text(widget.workoutName)),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewExercise,
          child: Icon(Icons.add),
        )
        body: ListView.builder(
          itemCount: value.numberOfExercisesInWorkout(widget.workoutName),
          itemBuilder: (context, index) => ExerciseTile(
            exerciseName: value
              .getReleventWorkout(widget.workoutName)
              .exercise[index]
              .name,
            weight: value
              .getReleventWorkout(widget.workoutName)
              .exercise[index]
              .weight,
            reps: value
              .getReleventWorkout(widget.workoutName)
              .exercise[index]
              .reps,
            sets: value
              .getReleventWorkout(widget.workoutName)
              .exercise[index]
              .sets,
            isCompleted: value
              .getReleventWorkout(widget.workoutName)
              .exercise[index]
              .isCompleted,
            onCheckBoxChanged: (val) => onCheckBoxChanged(
              widget.workoutName, 
              value
                .getReleventWorkout(widget.workoutName)
                .exercise[index]
                .name,
            ),
          )
        )
      ), // Scafold
    ); // Consumer
  }
}
