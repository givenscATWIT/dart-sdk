import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  // current logged in user
  User? currentUser = FirebaseAuth.instance.currentUser;

  // future to fetch for user details
  Future <DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
      .collection("Users")
      .doc(currentUser!.email)
      .get();
  }

  @override
  Widget build (BuildContext context){
    return const Scafold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ), // AppBar
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<<DocumentSnapshot<Map<String, dynamic>>>>(
        future: getUserDetails(),
        builder: (context, snapshot){
          // loading..
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircullarProgressIndicator(),
            ); // Center
          }

          // error
          else if (snapshot.hasError){
            return Text("Error: ${snapshot.error}");
          }

          // data received
          else if (snapshot.hasData){
            // extract data
            Map<String, dynamic>? user = snapshot.data!.data();

            return Center(
              child: Column(
                children: [
                  // back button
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 50.0,
                      left: 25,
                    ),
                    child: Row(
                      children[
                        MyBackButton(),
                      ], 
                    ), // Row
                  ), // Padding
                  
                  
                  const SizedBox(height: 25),

                  // profile picture
                  Container(
                    decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary,
                    borderRadius: borderRadius.circullar(24),
                    ),
                    padding: const EdgeInsets.all(25),
                    child: const Icon(
                      Icons.person,
                      size: 64,
                    ), // Icon
                  ), // Container

                  const SizedBox(height: 25),

                  // username
                  Text(
                    user['username'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ), // TextStyle
                  ), // Text

                  const SizedBox(height: 10),

                  // email
                  Text(
                    user['email'],
                    style: const TextStyle(
                      color: Colors.grey[600],
                    ), // TextStyle
                  ), // Text
                ], // children
              ); // Column
            )

          }
          else {
            return const Text("No data");
          }
        },
      ), // FutureBuilder
    ); // Scafold
  }
}
