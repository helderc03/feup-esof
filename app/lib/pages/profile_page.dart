import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/pages/login_page.dart';
import 'package:crypto/crypto.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import '../reusableWidgets/custom_nav_bar.dart';

class ProfilePage extends StatelessWidget {
  final String email;
  final String username;
  final String password;

  const ProfilePage(
      {Key? key,
        required this.email,
        required this.username,
        required this.password})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavBar(
        email: this.email,
        username: this.username,
        password: this.password,
      ),
      backgroundColor: const Color.fromRGBO(6, 10, 43, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(6, 10, 43, 1),
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          KeyedSubtree(
            key: Key("LogOutButton"), // Provide the desired key here
            child: IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage(key: Key("LoginPage"))),
                  )
                });
              },
            ),
          ),
        ],
      ),
      body: ImageWidget(email: email, username: username, password: password),
    );
  }
}

class ImageWidget extends StatefulWidget {
  final String email;
  final String password;
  final String username;

  const ImageWidget(
      {Key? key,
        required this.email,
        required this.username,
        required this.password})
      : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ImageWidget> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  User? user;
  String? url;
  bool isEditing=false;
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      usernameController.text = user?.displayName ?? "";
      emailController.text = user?.email ?? "";
      url = "https://0.gravatar.com/avatar/" +
          md5.convert(utf8.encode(emailController.text)).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.12,
                      left: MediaQuery.of(context).size.width * 0.33,
                      child: Stack(
                        children: [
                          ClipOval(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image: NetworkImage(url ?? "No image"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () async {
                                final uri = Uri.parse("https://gravatar.com/emails/");
                                if (await canLaunchUrl(uri)) {
                                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                                }
                              },
                              child: Container(
                                width: 40.0,
                                height: 40.0,

                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white, // Change the color of the camera icon
                                  size: 40.0, // Adjust the size of the camera icon
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),


                    Center(

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height * 0.40),
                            Row(
                              children: [

                                Container(
                                  width: 40.0,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(6, 10, 43, 1),
                                  ),
                                  child: Icon(
                                    Icons.mail_lock_sharp,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Expanded(child: _emailField(emailController.text)),
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                            Row(
                              children: [

                                Container(
                                  width: 40.0,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(6, 10, 43, 1),
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Expanded(child: _inputField(usernameController)),
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                            ElevatedButton(
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.hovered))
                                      return Colors.white; //<-- Color when hovered
                                    return Colors.red; //<-- Default color
                                  },
                                ),
                                foregroundColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) => Colors.white),
                                backgroundColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) => Colors.white),
                                fixedSize: MaterialStateProperty.all(Size(300, 50)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(color: Colors.white, width: 2),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                final lastDisplayName = user?.displayName ?? '';
                                final newDisplayName = usernameController.text;
                                user?.updateDisplayName(newDisplayName).then((value) {
                                  user = FirebaseAuth.instance.currentUser;
                                  if (newDisplayName == lastDisplayName) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Nothing updated!'),
                                        duration: Duration(seconds: 3),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } else {
                                    setState(() async{

                                      final Query query = users.where('email', isEqualTo: widget.email);
                                      final QuerySnapshot querySnapshot = await query.get();
                                      final List<QueryDocumentSnapshot> documents = querySnapshot.docs;

                                      if (documents.isNotEmpty) {
                                        final DocumentSnapshot document = documents.first;
                                        final DocumentReference documentRef = users.doc(document.id);

                                        await documentRef.update({'username': newDisplayName});
                                      }
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Updated ' + newDisplayName + '!'),
                                        duration: Duration(seconds: 3),
                                        backgroundColor: Color.fromRGBO(0, 150, 100, 1),
                                      ),
                                    );
                                  }
                                });
                              }, // Add space between email and logout button
                              child: Text(
                                'Update Profile',
                                style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.height * 0.03,
                                    color: Color.fromRGBO(6, 10, 43, 1)),
                              ),
                            ),

                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Image.asset(
            'assets/logo.png',
            width: 50.0,
            height: 50.0,
          ),
        ),
      ],
    );
  }

  Widget _inputField(TextEditingController controller, {bool isPassword = false}) {
    final double textFieldWidth = MediaQuery.of(context).size.width * 0.8;
    final double textFieldHeight = MediaQuery.of(context).size.height * 0.08;

    var border = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white), // Set the color of the line
    );
    return Container(
      width: textFieldWidth,
      height: textFieldHeight,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              controller: controller,
              decoration: InputDecoration(
                enabledBorder: border,
                focusedBorder: border,
              ),
              enabled: isEditing,
              obscureText: isPassword,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              onPressed: () {
                setState(() {
                  isEditing = !isEditing;
                });
              },
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget _emailField(String email) {
    final double textFieldWidth = MediaQuery.of(context).size.width * 0.8;
    final double textFieldHeight = MediaQuery.of(context).size.height * 0.08;

    return Container(
        width: textFieldWidth,
        height: textFieldHeight,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Text(
                  email,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            )));
  }
}
