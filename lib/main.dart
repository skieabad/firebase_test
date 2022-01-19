import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_test/screens/home.dart';
import 'package:firebase_test/state/state_management.dart';
import 'package:firebase_test/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth_ui/flutter_auth_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/src/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:scrumlab_colored_progress_indicators/scrumlab_colored_progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'customized_button/customized_button.dart';
import 'views/onboarding_page.dart';

bool? seenOnboard;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // to avoid null issue
  runApp(const ProviderScope(child: MyApp()));

  // to load splash screen for the first time only
  SharedPreferences? pref = await SharedPreferences.getInstance();
  seenOnboard = pref.getBool('seenOnboard') ?? false; //
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Test',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/home':
            return PageTransition(
                settings: settings,
                child: const Home(),
                type: PageTransitionType.fade);

          case '/login':
            return PageTransition(
                settings: settings,
                child: LoginScreen(),
                type: PageTransitionType.fade);

          default:
            return null;
        }
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: seenOnboard == true ? LoginScreen() : const OnBoardingPage(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class LoginScreen extends ConsumerWidget {
  GlobalKey<ScaffoldState> _scaffoldState = new GlobalKey();

  processLogin(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      FlutterAuthUi.startUi(
              items: [AuthUiProvider.phone],
              tosAndPrivacyPolicy: TosAndPrivacyPolicy(
                  tosUrl: 'https://google.com',
                  privacyPolicyUrl: 'https://google.com'),
              androidOption: const AndroidOption(
                  enableSmartLock: false, showLogo: true, overrideTheme: true))
          .then((value) async {
        // Refresh the state
        context.read(userLogged).state = FirebaseAuth.instance.currentUser;
        // Start a new screen
        await checkLoginState(context, true);
      }).catchError((e) {
        ScaffoldMessenger.of(_scaffoldState.currentContext!)
            // ignore: unnecessary_string_interpolations
            .showSnackBar(SnackBar(content: Text('${e.message}')));
      });
    }
    // user already login, start home page
    else {}

    // user == null
    //     ? FlutterAuthUi.startUi(
    //             items: [AuthUiProvider.phone],
    //             tosAndPrivacyPolicy: TosAndPrivacyPolicy(
    //                 tosUrl: 'https://google.com',
    //                 privacyPolicyUrl: 'https://google.com'),
    //             androidOption: const AndroidOption(
    //                 enableSmartLock: false,
    //                 showLogo: true,
    //                 overrideTheme: true))
    //         .then((value) async {
    //         // Refresh the state
    //         context.read(userLogged).state = FirebaseAuth.instance.currentUser;
    //         // ignore: avoid_print
    //         print('User login');
    //       }).catchError((e) {
    //         ScaffoldMessenger.of(_scaffoldState.currentContext!).showSnackBar(
    //           const SnackBar(
    //             content: Text('Unk error'),
    //           ),
    //         );
    //       })
    //     : Container(); // user already login, start home page
  }

  Future<LOGIN_STATE> checkLoginState(
      BuildContext context, bool fromLogin) async {
    await Future.delayed(Duration(seconds: fromLogin == true ? 0 : 2))
        .then((value) => {
              FirebaseAuth.instance.currentUser!.getIdToken().then((value) {
                // ignore: avoid_print
                print('Token $value');
                context.read(userToken).state = value;
                // user already login, we will start new screen
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/home', (route) => false);
              })
            });
    return FirebaseAuth.instance.currentUser != null
        ? LOGIN_STATE.LOGGED
        : LOGIN_STATE.NOT_LOGIN;
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldState,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/almostdone.png'),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder(
                    future: checkLoginState(context, false),
                    builder: (context, snapshot) {
                      var userState = snapshot.data as LOGIN_STATE;
                      if (snapshot.connectionState == ConnectionState.waiting)
                        // ignore: curly_braces_in_flow_control_structures
                        return const Center(child: CircularProgressIndicator());
                      else if (userState == LOGIN_STATE.LOGGED) {
                        return Container();
                      } else {
                        return GradientOutlineButton(
                          child: Text(
                            'Login by using your phone number',
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                            ),
                          ),
                          gradient: const LinearGradient(
                              colors: [Colors.blue, Colors.black]),
                          onPressed: () => processLogin(context),
                          strokeWidth: 4,
                          radius: 14,
                          icon: const Icon(Icons.phone),
                          margin: const EdgeInsets.all(2),
                          padding: const EdgeInsets.all(2),
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
