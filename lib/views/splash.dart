import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:task/utils/shared_preference.dart';
import 'package:task/views/home.dart';
import 'package:task/views/login.dart';

class SplashScreen extends StatefulWidget {
  static const _tag = "Splash";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SharedPrefsHandler _sharedPrefsHandler = SharedPrefsHandler.instance;

  @override
  void initState() {
    super.initState();
    openPage();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  void openPage() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (_sharedPrefsHandler.getString(SharedPrefsHandler.emailKey) != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFADC77),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Text(
                    '',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 50, fontStyle: FontStyle.italic),
                  ),
                ),
                const SizedBox(width: 7),
                SizedBox(height: 120, width: 120, child: Image.asset('assets/stock.png', fit: BoxFit.scaleDown))
              ],
            ),
            SpinKitChasingDots(
              size: 100,
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index.isEven ? const Color(0xFFFDFEDE) : Colors.orangeAccent,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
