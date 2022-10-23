

import 'package:airportify/getx_ui/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../controllers/auth_controller.dart';
import 'bottom_nav_screen.dart';

class PhoneLoginScreen extends StatelessWidget {
  PhoneLoginScreen({Key? key}) : super(key: key);

  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _phoneNoNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();

  String email ='';
  String password = '';

  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final t = Theme.of(context);
    final s = MediaQuery.of(context).textScaleFactor;

    return GetX<AuthController>(
        builder: (controller) {
          if (controller.hasInternet==false) {
            return buildNoInternetPage(context);
          } else {
            return GestureDetector(
              onTap: (){
                _phoneNoNode.unfocus();
              },
              child: Scaffold(
                backgroundColor: Colors.white,
                resizeToAvoidBottomInset: true,
                extendBodyBehindAppBar: true,
                body: SingleChildScrollView(
                  child: GetX<AuthController>(
                      builder: (ctrl) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: h*0.4,),
                            Center(
                              child: Container(
                                width: w*0.9,
                                height:ctrl.adminPass.value==true? h*0.4: h*0.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          offset: const Offset(0,4),
                                          blurRadius: 5,
                                          spreadRadius: 0
                                      )
                                    ]
                                ),
                                child:Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Hi",style: GoogleFonts.roboto(
                                          fontSize: 17*s,
                                          // color: const Color(0xff909090),
                                          color: Theme.of(context).scaffoldBackgroundColor,
                                          fontWeight: FontWeight.bold
                                      ),),
                                      Text("Let's get you acquainted",style:GoogleFonts.roboto(
                                        fontSize: 19*s,
                                        color: Theme.of(context).scaffoldBackgroundColor,
                                        fontWeight: FontWeight.bold,
                                      ) ,),
                                      SizedBox(height: h*0.02,),
                                      TextFormField(
                                        controller: _phoneNoController,
                                        focusNode: _phoneNoNode,
                                        keyboardType: TextInputType.phone,
                                        style: TextStyle(
                                          fontSize: 16*s,
                                          color: Colors.black,
                                          letterSpacing: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        decoration: InputDecoration(
                                            counterText: '',
                                            focusColor: Colors.transparent,
                                            filled: true,
                                            fillColor: const Color(0xffffffff),
                                            // fillColor: const Color(0xff393939),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              borderSide: const BorderSide(
                                                  style: BorderStyle.none
                                              ),
                                            ),
                                            prefix: const Text("+91",style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17
                                            ),),
                                            // prefixIcon: const Icon(Icons.phone,color: Color(0xff767676),size: 35,),
                                            hintText: "Phone Number",
                                            hintStyle: const TextStyle(
                                                fontSize: 16,
                                                color: Color(0xff767676),
                                                letterSpacing: 1
                                            )
                                        ),
                                        maxLength: 10,
                                        onFieldSubmitted: (text){
                                          if(text=='1234567890'){
                                            ctrl.adminPass.value = true;
                                          }
                                          email = text;
                                        },
                                      ),

                                      SizedBox(height: h*0.01,),
                                      if(ctrl.adminPass.value==true) Text("Password",style:GoogleFonts.roboto(
                                        fontSize: 15*s,
                                        color: Theme.of(context).scaffoldBackgroundColor,
                                        fontWeight: FontWeight.bold,
                                      ) ,),
                                      if(ctrl.adminPass.value==true)TextFormField(
                                        controller: _passwordController,
                                        focusNode: _passwordNode,
                                        keyboardType: TextInputType.phone,
                                        style: TextStyle(
                                          fontSize: 16*s,
                                          color: Colors.white,
                                          letterSpacing: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        decoration: InputDecoration(
                                            counterText: '',
                                            focusColor: Colors.transparent,
                                            filled: true,
                                            fillColor: const Color(0xff00171F),
                                            // fillColor: const Color(0xff393939),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              borderSide: const BorderSide(
                                                  style: BorderStyle.none
                                              ),
                                            ),
                                            // prefixIcon: const Icon(Icons.phone,color: Color(0xff767676),size: 35,),
                                            hintText: "Password",
                                            hintStyle: const TextStyle(
                                                fontSize: 16,
                                                color: Color(0xff767676),
                                                letterSpacing: 1
                                            )
                                        ),
                                        maxLength: 5,
                                        onFieldSubmitted: (text){
                                          password = text;
                                        },
                                      ),

                                      SizedBox(height: h*0.02,),
                                      Center(
                                        child: InkWell(
                                          onTap: ()async{
                                            /// Meaning we are closing these pages for good.
                                            if(_phoneNoController.text.length!=10){
                                              Fluttertoast.showToast(
                                                  msg: "Phone Number is not 10 digits",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.SNACKBAR,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0
                                              );


                                            }else{
                                              print("phone no :${_phoneNoController.text}]\nPassword :${_passwordController.text}");
                                              if(_phoneNoController.text=='1234567890' && _passwordController.text == '12345'){
                                                await FirebaseAuth.instance.signInAnonymously();
                                                Get.to(()=>BottomNavigationScreen());
                                              }else{
                                                Get.offAll(()=> OTPScreen(phoneNumber: _phoneNoController.text,));

                                              }
                                            }
                                          },
                                          child: Container(
                                            width: w*0.4,
                                            height: h*0.05,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: const Color(0xff1E1E1E),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black.withOpacity(0.8),
                                                      offset: const Offset(0,4),
                                                      blurRadius: 4,
                                                      spreadRadius: 0
                                                  )
                                                ]
                                            ),
                                            child: Center(child: Text("Sign up ",style:TextStyle(
                                                fontSize: 16*s,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold
                                            ) ,),),
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            )

                          ],
                        );
                      }
                  ),
                ),
              ),
            );
          }
        }

    );
  }

  Widget buildNoInternetPage(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
              'assets/lottie/90478-disconnect.json',
              fit: BoxFit.contain,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4
          ),
          Text("Device is not connected to internet!",style: Theme.of(context).textTheme.caption!.copyWith(
              color: Theme.of(context).primaryColor
          ),)
        ],
      ),
    );
  }
}
