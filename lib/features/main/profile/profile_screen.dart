import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:personal_financial_management/core/constants/app_colors.dart';
import 'package:personal_financial_management/core/constants/app_styles.dart';
import 'package:personal_financial_management/core/constants/function/loading_animation.dart';
import 'package:personal_financial_management/core/constants/function/route_function.dart';
import 'package:personal_financial_management/features/auth/change_password/change_password.dart';
import 'package:personal_financial_management/features/main/profile/export_csv.dart';
import 'package:personal_financial_management/features/main/profile/language_selector.dart';
import 'package:personal_financial_management/features/main/profile/view_profile_screen.dart';
import 'package:personal_financial_management/setting/localization/app_localizations.dart';
import 'package:personal_financial_management/models/user.dart' as myuser;
import 'package:intl/intl.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:personal_financial_management/features/main/profile/history_screen.dart';
import 'package:personal_financial_management/features/main/profile/currency_exchange_rate.dart';
import 'package:personal_financial_management/features/main/profile/about_screen.dart';
import 'package:personal_financial_management/features/main/profile/widget/info_widget.dart';
import 'package:personal_financial_management/features/main/profile/widget/setting_item.dart';
import 'package:personal_financial_management/setting/bloc/setting_cubit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var numberFormat = NumberFormat.currency(locale: "vi_VI");
  int language = 0;
  bool darkMode = false;
  bool loginMethod = false;

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        language = value.getInt('language') ?? (Platform.localeName.split('_')[0] == "vi" ? 0 : 1);
        darkMode = value.getBool("isDark") ?? false;
        loginMethod = value.getBool("login") ?? false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("info")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  myuser.User user = myuser.User.fromFirebase(snapshot.requireData);
                  return InfoWidget(user: user);
                }
                return const InfoWidget();
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      settingItem(
                        text: AppLocalizations.of(context).translate('account'),
                        action: () {
                          Navigator.of(context).push(createRoute(
                            screen: const UserProfilePage(),
                            begin: const Offset(1, 0),
                          ));
                        },
                        icon: FontAwesomeIcons.solidUser,
                        color: const Color.fromRGBO(0, 150, 255, 1),
                      ),
                      if (loginMethod) const SizedBox(height: 20),
                      if (loginMethod)
                        settingItem(
                          text: AppLocalizations.of(context).translate('change_password'),
                          action: () {
                            Navigator.of(context).push(createRoute(
                              screen: const ChangePassword(),
                              begin: const Offset(1, 0),
                            ));
                          },
                          icon: FontAwesomeIcons.lock,
                          color: const Color.fromRGBO(233, 116, 81, 1),
                        ),
                      const SizedBox(height: 20),
                      settingItem(
                        text: AppLocalizations.of(context).translate('language'),
                        action: _showBottomSheet,
                        icon: Icons.translate_outlined,
                        color: const Color.fromRGBO(218, 165, 32, 1),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(90),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: const Icon(
                              FontAwesomeIcons.solidMoon,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            AppLocalizations.of(context).translate('dark_mode'),
                            style: const TextStyle(fontSize: 18),
                          ),
                          const Spacer(),
                          FlutterSwitch(
                            height: 30,
                            width: 60,
                            value: darkMode,
                            onToggle: (value) async {
                              BlocProvider.of<SettingCubit>(context).changeTheme();
                              setState(() => darkMode = value);
                              final prefs = await SharedPreferences.getInstance();
                              await prefs.setBool('isDark', darkMode);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      settingItem(
                        text: AppLocalizations.of(context).translate('history'),
                        action: () {
                          Navigator.of(context).push(createRoute(
                            screen: const HistoryPage(),
                            begin: const Offset(1, 0),
                          ));
                        },
                        icon: Icons.history_rounded,
                        color: const Color.fromRGBO(121, 189, 161, 1),
                      ),
                      const SizedBox(height: 20),
                      settingItem(
                        text: "${AppLocalizations.of(context).translate('export')} CSV",
                        action: () async {
                          loadingAnimation(context);
                          await ExportCSV.exportCSV(context);
                          if (!mounted) return;
                          Navigator.pop(context);
                        },
                        icon: Icons.archive_outlined,
                        color: const Color.fromRGBO(137, 207, 240, 1),
                      ),
                      const SizedBox(height: 20),
                      settingItem(
                        text: AppLocalizations.of(context).translate('currency_exchange_rate'),
                        action: () async {
                          Navigator.of(context).push(createRoute(
                            screen: const CurrencyExchangeRate(),
                            begin: const Offset(1, 0),
                          ));
                        },
                        icon: Icons.attach_money_rounded,
                        color: const Color.fromRGBO(255, 192, 0, 1),
                      ),
                      const SizedBox(height: 20),
                      settingItem(
                        text: AppLocalizations.of(context).translate('about'),
                        action: () {
                          Navigator.of(context).push(createRoute(
                            screen: const AboutPage(),
                            begin: const Offset(1, 0),
                          ));
                        },
                        icon: FontAwesomeIcons.circleInfo,
                        color: const Color.fromRGBO(79, 121, 66, 1),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.buttonLogin,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            await GoogleSignIn().signOut();
                            await FacebookAuth.instance.logOut();
                            if (!mounted) return;
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/login', (route) => false);
                          },
                          child: Text(
                            AppLocalizations.of(context).translate('logout'),
                            style: AppStyles.p,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      context: context,
      builder: (context) {
        return LanguageSelector(
          currentLanguage: language,
          onLanguageChanged: (lang) async {
            changeLanguage(lang);
          },
        );
      },
    );
  }

  Future changeLanguage(int lang) async {
    if (lang != language) {
      if (lang == 0) {
        BlocProvider.of<SettingCubit>(context).toVietnamese();
      } else {
        BlocProvider.of<SettingCubit>(context).toEnglish();
      }
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('language', lang);
      if (!mounted) return;
      setState(() => language = lang);
    }

    if (!mounted) return;
    Navigator.pop(context);
  }
}
