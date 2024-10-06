import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF060a2b),
            Color(0xFF0a0e3c),
          ],
        ),
        border: Border.all(
          color: Colors.black,
          width: 10,
        ),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(6, 10, 43, 1),
          elevation: 0.0,
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery
              .of(context)
              .size
              .width * 0.001, vertical: 0),
          child: _page(),
        ),
      ),
    );
  }

  Widget _page() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery
            .of(context)
            .size
            .width * 0.001, vertical: 0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _icon(),
              const SizedBox(height: 15),
              KeyedSubtree(
                key: Key("emailField"), // Unique key for the email TextField
                child: _inputField("Email", emailController),
              ),
              const SizedBox(height: 20),
              KeyedSubtree(
                key: Key("usernameField"), // Unique key for the email TextField
                child: _inputField("Username", usernameController),
              ),
              const SizedBox(height: 20),
              KeyedSubtree(
                key: Key("passwordField"), // Unique key for the password TextField
                child: _inputField("Password", passwordController, isPassword: true),
              ),
              const SizedBox(height: 50),
              _createAccountBtn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _icon() {
    final double iconSize = MediaQuery
        .of(context)
        .size
        .width * 0.40;
    return SizedBox(
      width: iconSize,
      height: iconSize,
      child: Image.asset('assets/logo.png'),
    );
  }

  Widget _inputField(String hintText, TextEditingController controller,
      {bool isPassword = false}) {
    final double textFieldWidth = MediaQuery
        .of(context)
        .size
        .width * 0.8;
    final double textFieldHeight = MediaQuery
        .of(context)
        .size
        .height * 0.08;
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(textFieldHeight * 0.5),
        borderSide: const BorderSide(color: Colors.white));

    return SizedBox(
      width: textFieldWidth,
      height: textFieldHeight,
      child: TextField(
        style: const TextStyle(color: Colors.white),
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
          enabledBorder: border,
          focusedBorder: border,
        ),
        obscureText: isPassword,
      ),
    );
  }


  Widget _createAccountBtn() {
    final signUpButtonKey = Key("signUpButton");
    final double buttonWidth = MediaQuery
        .of(context)
        .size
        .width * 0.8;
    final double buttonHeight = MediaQuery
        .of(context)
        .size
        .height * 0.08;
    CollectionReference users = FirebaseFirestore.instance.collection('users');


    return SizedBox(
      key: signUpButtonKey,
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: () async {
          QuerySnapshot queryUsername = await users.where(
              'username', isEqualTo: usernameController.text).get();
          QuerySnapshot queryEmail = await users.where('email',isEqualTo: emailController.text).get();
          if (queryEmail.docs.isNotEmpty){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(
                  'An account with this email already exists! Sign in!'),
                duration: Duration(seconds: 3),
                backgroundColor: Color.fromRGBO(80, 0, 100, 1),
              ),);
          }
          else if (queryUsername.docs.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(
                  'The username already exists! Please try another one!'),
                duration: Duration(seconds: 3),
                backgroundColor: Color.fromRGBO(80, 0, 100, 1),
              ),);
          }
          if (passwordController.text.length < 7){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    'ERROR! Please fill all fields and check if password has at least 7 characters'),
                duration: Duration(seconds: 3),
                backgroundColor: Color.fromRGBO(80, 0, 100, 1),
              ),
            );
          }
          else {
            await users.add({
              'username': usernameController.text,
              'email': emailController.text
            });
            FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            ).then((value) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Welcome ' + usernameController.text + ' !'),
                  duration: Duration(seconds: 3),
                  backgroundColor: Color.fromRGBO(0, 150, 100, 1),
                ),
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MyHomePage(
                        key: Key("HomePage"),
                        email: emailController.text,
                        username: usernameController.text,
                        password: passwordController.text,
                      ),
                ),
              );
            }).onError((error, stackTrace) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'ERROR! Please fill all fields and check if password has at least 6 characters'),
                  duration: Duration(seconds: 3),
                  backgroundColor: Color.fromRGBO(80, 0, 100, 1),
                ),
              );
            });
          }
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: const Color.fromRGBO(6, 10, 43, 1),
          shape: const StadiumBorder(),
          backgroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: buttonHeight * 0.2),
        ),
        child: const SizedBox(
          width: double.infinity,
          child: Text(
            "Create Account",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}


