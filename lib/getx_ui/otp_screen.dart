import 'package:airportify/getx_ui/bottom_nav_screen.dart';
import 'package:airportify/getx_ui/phone_login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../controllers/auth_controller.dart';
import 'onboarding_screens.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;
  const OTPScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final AuthController authController = Get.find();
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinNode = FocusNode();

  ///For phone verification
  String _verificationCode = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ///This will call the below function which will send the OTP ASAP
    _verifyPhone();
  }

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).textScaleFactor;
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: TextStyle(fontSize: 19*s, color: const Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(197, 197, 197, 1.0)),
        borderRadius: BorderRadius.circular(15),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );
    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: (){
            _pinNode.unfocus();
          },
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.1,),
              Center(
                child: Text("Verify your \n Phone number",textAlign: TextAlign.center,style:GoogleFonts.roboto(
                    fontSize: 23*s,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                )  ,),
              ),
              const SizedBox(height: 10,),
              Center(child:Text('+91${widget.phoneNumber}',style: GoogleFonts.roboto(
                fontSize: 14*s,
                color: Colors.grey,
                fontWeight: FontWeight.normal,
              ),)),
              const SizedBox(height: 7,),
              Center(child:Text("Enter your OTP code here",style: GoogleFonts.roboto(
                fontSize: 14*s,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),)),
              const SizedBox(height: 25,),


              Pinput(
                closeKeyboardWhenCompleted: false,
                length: 6,
                keyboardType: TextInputType.number,
                showCursor: false,
                focusNode: _pinNode,
                textInputAction: TextInputAction.none,
                controller: _pinPutController,
                onCompleted: (String pin)async{
                  try{
                    await FirebaseAuth.instance
                        .signInWithCredential(PhoneAuthProvider.credential(verificationId: _verificationCode, smsCode: pin))
                        .then((value) async{
                      if(value.user!=null){
                        print('User Logged in Successfully via pinPut');

                        ///Checking if the user(phoneNumber) already exists
                        ///If yes: Then we direct the user to the home screen
                        ///Else : We proceed to the on boarding section
                        Get.to(()=>BottomNavigationScreen());
                      }else{
                        Get.to(()=>OnBoardingScreens());
                      }
                    });
                  }catch(e){
                    FocusScope.of(context).unfocus();
                    Fluttertoast.showToast(
                        msg: 'Invalid OTP Entered',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.SNACKBAR,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                },
                submittedPinTheme: submittedPinTheme,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
              ),


              const SizedBox(height: 25,),
              Center(child:Text("Didn't receive any code?",style:GoogleFonts.roboto(
                fontSize: 14*s,
                color: Colors.grey,
                fontWeight: FontWeight.normal,
              ) ,)),
              const SizedBox(height: 10,),
              Center(child:InkWell(
                onTap: (){
                  _verifyPhone();
                },
                child: Text("Resend OTP",style:GoogleFonts.roboto(
                  fontSize: 19*s,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontWeight: FontWeight.normal,
                ) ,),
              )),
              SizedBox(height: h*0.4,),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: InkWell(
                  onTap: (){
                    Get.offAll(()=>PhoneLoginScreen());
                  },
                  child: Container(
                    width: w*0.5,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child:Text("Change Number",style: GoogleFonts.roboto(
                      color:Colors.white,
                      fontSize: 17*s,
                      fontWeight: FontWeight.w500,
                    ),)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phoneNumber}',
        verificationCompleted: (PhoneAuthCredential credentials) async{
          await FirebaseAuth.instance.signInWithCredential(credentials).then((value) async {
            if(value.user!=null){
              Get.to(()=>BottomNavigationScreen());
            }else{
              Get.to(()=>OnBoardingScreens());
            }
          });
        },
        verificationFailed: (FirebaseException e) {
          Fluttertoast.showToast(
            msg: 'Phone Verification Error : ${e.message}',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.SNACKBAR,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        },
        codeSent: (String verificationID, int? resendToken) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        });
  }
}
