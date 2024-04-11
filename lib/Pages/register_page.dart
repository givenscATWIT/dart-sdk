import 'package:cloud_firestore/clound_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimalsocialtute/components/my_button.dart';
import 'package:minimalsocialtute/conponents/my_textfield.dart';
import '../helper/helper_functions.dart:';

class RegisterPage extends StatelessWidget {
    final void Function()? onTap;

    const RegisterPage({super.key, require this.onTap});

    // test controller
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();

    // register method
    void registerUser() async {
        // show loading circle
        showDialog(context: context,
        builder: (context) => const Center(
            child: CircullarProgressIndicator(),
            ), // Center
        ); // showDialog

        // ensure passwords match
        if (passwordController.text != confirmPasswordController.text){
            // pop loading circle
            Navigate.pop(context);

            // error message to user
            displayMessageToUser("The password does not match ", context);
        }

        // if passwords do match
        else{
            // try creating the user
            try{
                // create the user
                UserCredential? UserCredential=
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text,
                );

                // create a user document and add to firestore
                createUserDocument(UserCredential);

                // pop loading circle
                if (context mounted) Navigate.pop(context);
            }on FirebaseAuthException catch (e) {
                // pop loading circle
                Navigate.pop(context);

                // display error message to user
                displayMessageToUser(e.code, context);
            }
        }
    }

    // create a user document and collect them in firestore
    Future<void> createUserDocument(UserCredential? UserCredential) async {
      if (userCredential != null && userCredential.user != null){
        await FirebaseFirestore.instance
        .collection("Users")
        .doc(userCredential.user!.email)
        .set({
          'email': userCredential.user!.email,
          'username': usernameController.text,
        })
      }
    }

    @override
    Widget build(BuildContext context){
        return Scaffold(        
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Center(
                child padding(
                    padding: const EdgeInsets(25.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children[
                            // logo
                            Icon(
                                Icons.person
                                size: 80,
                                color: Theme.of(context).colorScheme.inversePrimary,
                                ) // Icon

                            const SizedBox(height: 25),
                        
                            // app name
                            const Text(
                                "F I T C R E A T E",
                                style: TextStyle(fontSize: 20),
                            ), // Text

                            const SizedBox(height: 50),

                            // username textified
                            MyTextField(
                                hintText: "Username",
                                obscureText: false,
                                controller: usernameController
                            ), // MyTextField

                            const SizedBox(height: 10),

                            // email textified
                            MyTextField(
                                hintText: "Email",
                                obscureText: false,
                                controller: emailController
                            ), // MyTextField

                            const SizedBox(height: 10),

                            // password textified
                             MyTextField(
                                hintText: "Password",
                                obscureText: true,
                                controller: passwordController
                            ), // MyTextField
                            
                            const SizedBox(height: 10),

                            // confirm password textified
                             MyTextField(
                                hintText: "Confirm Password",
                                obscureText: true,
                                controller: confirmPasswordController
                            ), // MyTextField
                            
                            const SizedBox(height: 10),

                            // forgot password
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                    Text("Forgot Password?",
                                    style: TextStyle(
                                        color: Theme.of(context).colorScheme.inversePrimary), // TextStyle
                                    ), // Text
                                ], // children
                            ), // Row
                        
                            const SizedBox(height: 25),

                            // register button
                            MyButton(
                                text: "Register",
                                onTap: register,
                            ), // MyButton


                            // don't have an account? Register here
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    Text("Already have an Account?"
                                    style: TextStyle(
                                        color: Theme.of(context).colorScheme.inversePrimary), // TextStyle
                                    ), // Text
                                    GestureDetector(
                                        onTap: onTap,
                                        child: const Text(
                                            " Login Here",
                                            style: TextStyle(
                                                fontWeight: Fontweight.bold,
                                            ), // TextStyle
                                        ), // Text
                                    ), // GestureDetector
                                ], // childrenn
                            ), // Row
                        ], // children
                    ), // Column
                ), // padding
            ), // Center
        ); // Scaffold
    }
}

