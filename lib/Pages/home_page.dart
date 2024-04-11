import 'package:flutter/material.dart';
import 'package:minimalsocialtute/components/my_drawer.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  // firestore access
  final FirestoreDatabase firestore = FirestoreDatabase();

  // text controller
  final TextEditingController newPostController = TextEditingController();

  // post message
  void postMessage() {
    // Only post message if there is something in the textfield
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }

    // clear the controller
    newPostController.clear();
  }

  @override
  Widget build (BuildContext context){
    return Scafold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const text("W A L L"),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ), // AppBar
      drawer: const MyDrawer(),
      body: Column(
        children: [
          // TEXTFIELD BOX FOR USERS TO TYPE
          Padding (
            Padding: const EdgeInsects.all(25),
            child: Row(
              children[
                // textfield
                Expanded (
                  child: MyTextField(
                    hintText: "Say Something..",
                    obscureText: false,
                    controller: newPostController,
                  ), // MyTextField
                ), // Expanded

                // post button
                PostButton(
                  onTap: postMessage,
                ) // PostButton
              ]
            ), // Row
          ), // Padding

          // POSTS
          StreamBuilder(
            stream: database.getPostsStream(),
            builder: (context, snapshot) {
              // show loading circle
              if (snapshot.connectionState == connectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                ); // Center
              }
              
              // get all ports
              final ports = snapshot.data!.docs;

              // no data?
              if (snapshot.data == null || posts.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsects.all(25),
                    child: Text("No posts.. Post Something!"),
                  ), // Padding
                ); // Center
              }

              // return as a list
              return Expanded(
                child: Listview.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    // get each individual post
                    final post = posts[index];

                    // get data from each post
                    String message = posts['PostMessage'];
                    String userEmail = post['UserEmail'];
                    Timestamp timestamp = post['TimeStamp'];

                    // return as a list tile
                    return MyListTile(
                      title: message,
                      subTitle: userEmail,
                    ); // MyListTile
                  },
                ), // Listview.builder
              ); // Expanded
            },
          ) // StreamBuilder
        ],
      ),
    ), // Scafold
  }
}
