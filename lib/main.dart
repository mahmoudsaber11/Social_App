import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/bloc_observable.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/social_login/social_login_screen.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/styles/themes.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {}
void main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await CacheHelper.initSharedPref();

  // ignore: unused_local_variable
  bool? isDarkMode = CacheHelper.getBoolData(key: 'isDarkMode');

  Widget startWidget;

  uId = CacheHelper.getStringData(key: 'uId');
  if (uId != null) {
    startWidget = const SocialLayout(0);
  } else {
    startWidget = const SocialLoginScreen();
  }

  runApp(MyApp(
    startWidget,
    uId: uId,
  ));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  final Widget? startWidget;
  String? uId;

  MyApp(this.startWidget, {String? uId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit()),
        BlocProvider(
            create: ((BuildContext context) => SocialCubit()
              ..getUserData(uId)
              ..getPosts()
              ..getUsers())),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: AppCubit.get(context).isDarkMode
                  ? ThemeMode.light
                  : ThemeMode.dark,
              theme: MyTheme.lightTheme,
              darkTheme: MyTheme.darkTheme,
              home: startWidget,
            );
          }),
    );
  }
}
