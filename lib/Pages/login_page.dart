import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimalsocialtute/components/my_button.dart';
import 'package:minimalsocialtute/components/my_textfield.dart';
import 'package:minimalsocialtute/helper/helper_function.dart';

class LoginPage extends StatelessWidget {
    fianl void Function()? onTap;

    const LoginPage({super.key, require this.onTap});

    @override
    State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
    // test controller
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    // login method
    void login() {
        // show loading circle
        showDialog(context: context,
        builder: (context) => const Center(
            child: CircullarProgressIndicator(),
            ), // Center
        );
        // try signing in
        try{
            await FrebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text)

            // pop loading circle
            if(context.mounted) Navigator.pop(context);
        }

        // display any errors
        on FirebaseAuthException catch (e) {
            // pop loading screen
            Navigator.pop(context);
            displayMessageToUser(e.code, context);
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
                                "M I N I M A L",
                                style: TextStyle(fontSize: 20),
                            ), // Text

                            const SizedBox(height: 50),

                            // email textified
                            MyTextField(
                                hintText: "email",
                                obscureText: false,
                                controller: emailController
                                ), // MyTextField

                                const SizedBox(height: 10),

                            // password textified
                             MyTextField(
                                hintText: "password",
                                obscureText: true,
                                controller: passwordController
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

                            // sign in button
                            MyButton(
                                text: "Login",
                                onTap: login,
                            ), // MyButton


                            // don't have an account? Register here
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    Text("Don't have an Account?"
                                    style: TextStyle(
                                        color: Theme.of(context).colorScheme.inversePrimary), // TextStyle
                                    ), // Text
                                    GestureDetector(
                                        onTap: onTap,
                                        child: const Text(
                                            " Register Here",
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

