import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workouttutorial/data/workout_data.dart';

class HomePage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();

    Provider.of<WorkoutData>(context, listen: false).initalizedWorkoutList();
  }

  // text controller
  final newWorkoutNameController = TextEditingController();

  // create a new workout
  void createNewWorkout() {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text("Create new workout"),
        content: TextField(
          controller: newWorkoutNameController,
        ),
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
    );
  }

  // go to workout page
  void goToWorkoutPage(String workoutName) {
    Navigator.push(
      context, MaterialPageRoute(
        builder: (context) => WorkoutPage(
          workoutName: workoutName,
        ), // WorkoutPage
      ) // MaterialPageRoute
    );
  }

  // save workout
  void save() {
    // get workout name from text controller
    String newWorkoutName = newWorkoutNameController.text;
    // add workout to workoutdata list
    Provider.of<WorkoutData>(context, listen: false).addWorkout(newWorkoutName);

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
    newWorkoutNameController.clear();
  }

  @override
  Widget build(BuildContext context){
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scafold(
        backgroundColor: Colors.grey[300]
        appBar: AppBar(
          title: const Text('Workout Tracker'),
        ), // AppBar
        floatingActionButton: floatingActionButton(
          onPressed: createNewWorkout,
          child: const Icon(Icons.add),
        ), // floatingActionButton
        body: ListView(
          children: [
            //HEAT MAP
            MyHeatMap(
              datasets: value.heatMapDataSet,
              startDateYYYYMMDD: value.getStartDate(),
            ), // MyHeatMap

            // WORKOUT LIST
            ListView.builder(
              shrinkWrap: true,
              physics: const NaverScrollableScrollPhysics(),
              itemCount: value.getWorkoutList().length,
              itemBuilder: (context, index) => ListTile(
                title: Text(value.getWorkoutList()[index].name),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_adroid),
                  onPressed: () => goToWorkoutPage(value.getWorkoutList()[index].name),
                ), // IconButton
              ), // ListTile
            ) // ListView.builder
          ]
        ), // ListView.builder
      ), // Scafold
    ); // Consumer<WorkoutData>
  }
}
