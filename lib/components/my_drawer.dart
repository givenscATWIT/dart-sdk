import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // logout user
  void logout(){
    FirebaseAuth.instance.signOut();
  } 

  @override
  Widget build (BuildContext context){
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: column(
        mainAxisAlignment: mainAxisAlignment.spaceBetween,
        children: [
          Column(
            children[
              // draw header
              DrawerHeader(
                child: Icon(Icons.favorite,
                color: Theme.of(context).colorScheme.inversePrimary,
                ), // Icon
              ), // DrawerHeader

              const SizedBox(height: 25),

              // home tile
              Padding(
                padding: const EdgeInsects.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ), // Icon
                  title: const Text("H O M E"),
                  onTap: () {
                    // this is already the home screen so just pop drawer
                    Navigator.pop(context);
                  },
                ), // ListTile
              ), // Padding



              // profile tile
              Padding(
                padding: const EdgeInsects.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ), // Icon
                  title: const Text("P R O F I L E"),
                  onTap: () {
                    // pop drawer
                    Navigator.pop(context);

                    // Navigate to profile page
                    Navigator.pushNamed(context, '/profile_page');
                  },
                ), // ListTile
              ), // Padding

              // users tile
              Padding(
                padding: const EdgeInsects.only(left: 25.0, bottom: 25),
                child: ListTile(
                  leading: Icon(
                    Icons.group,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ), // Icon
                  title: const Text("U S E R S"),
                  onTap: () {
                    // this is already the home screen so just pop drawer
                    Navigator.pop(context);

                    // Navigate to profile page
                    Navigator.pushNamed(context, '/users_page');
                  },
                ), // ListTile
              ), // Padding
            ], // children
          ), // Column

          // logout tile
            Padding(
            padding: const EdgeInsects.only(left: 25.0),
            child: ListTile(
              leading: Icon(
                Icons.exit,
                color: Theme.of(context).colorScheme.inversePrimary,
              ), // Icon
              title: const Text("L O G O U T"),
              onTap: () {
                // pop drawer
                Navigator.pop(context);

                // logout
                logout();
              },
            ), // ListTile
          ), // Padding
        ], // children
      ), // column
    );
  }
}
