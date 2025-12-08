import 'package:LongLaoshi/screens/auth/firebase_auth_service.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? name, email, photoUrl, splitName;

  getUserData() async {
    final user = FirebaseAuthService().currentUser;
    print(user);
    setState(() {
      name = user?.displayName;
      email = user?.email;
      photoUrl = user?.photoURL;
      splitName = name?.split(' ')[0];
    });
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de usuario'),
        backgroundColor: Colors.indigoAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.indigoAccent,
              child: CircleAvatar(
                radius: 65,
                backgroundImage: NetworkImage(photoUrl ??
                    'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
              ),
            ),
            const SizedBox(height: 50),
            itemProfile('Nombre', splitName ?? "", Icons.person_outlined),
            const SizedBox(height: 40),
            itemProfile('Email', email ?? "", Icons.email_outlined),
            const SizedBox(
              height: 100,
            ),
            SizedBox(
              width: 200,
              height: 40,
              child: ElevatedButton(
                  onPressed: () {
                    FirebaseAuthService().signOut().then((value) {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/', (route) => false);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    padding: const EdgeInsets.all(15),
                    backgroundColor: Colors.red,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Cerrar sesión',
                      style: TextStyle(fontSize: 20, color: Colors.black87))),
            )
          ],
        ),
      ),
    );
  }

  itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 5),
                color: Colors.black.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 10)
          ]),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        tileColor: Colors.white,
      ),
    );
  }
}
