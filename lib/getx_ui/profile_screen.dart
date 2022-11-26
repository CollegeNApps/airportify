


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  final String name;
  const ProfileScreen({Key? key,required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: ()=> Navigator.pop(context),
            child: const Icon(Icons.chevron_left,color: Colors.black,size: 30,)),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              ClipOval(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 100,
                  child: CircleAvatar(
                    radius: 98,
                    backgroundImage: NetworkImage('https://i.pinimg.com/474x/91/56/38/91563839316e3af9722703dfb8f8a1d9.jpg'),

                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          Text("Welcome \n$name",style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 24
          ),textAlign: TextAlign.center,),
          const SizedBox(height: 10,),
          Text("Phone:  ${FirebaseAuth.instance.currentUser!.phoneNumber.toString()}",style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 18
          ),),
          const SizedBox(height: 10,),
          Text("Uid:  ${FirebaseAuth.instance.currentUser!.uid.toString()}",style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 15
          ),),

          SizedBox(height: h*0.1,),
          InkWell(
            onTap: () async{
              await FirebaseAuth.instance.signOut();
            },
            child: Container(
              width: w * 0.5,
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: Text(
                    "Sign out",
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
