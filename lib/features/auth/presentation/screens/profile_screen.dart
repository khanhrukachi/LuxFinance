import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_financial_management/core/constants/app_colors.dart';
import 'package:personal_financial_management/core/constants/app_sizes.dart';
import 'package:personal_financial_management/core/screens/loadingg_screen.dart';
import 'package:personal_financial_management/core/utils/utils.dart';
import 'package:personal_financial_management/features/auth/presentation/screens/edit_profile_screen.dart';
import 'package:personal_financial_management/features/auth/presentation/screens/introduce_screen.dart';
import 'package:personal_financial_management/core/constants/get_version.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  static const routeName = '/profile';

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      successMessage('Successfully signed out!', context);
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      wrongMessage('Error signing out. Please try again.', context);
    }
  }


  Future<Map<String, String>> getUserData() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        String fullName = userDoc['fullName'] ?? 'No full name available';
        String profilePicUrl = userDoc['profilePicUrl'] ?? '';
        return {'fullName': fullName, 'profilePicUrl': profilePicUrl};
      } else {
        return {'fullName': 'No full name available', 'profileImageUrl': ''};
      }
    } catch (e) {
      return {'fullName': 'Error retrieving full name', 'profileImageUrl': ''};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tài khoản'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.support_agent,
              color: AppColors.blackColor,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.xxSmall),
        child: Column(
          children: [
            const SizedBox(height: AppSizes.medium),
            FutureBuilder<Map<String, String>>(
              future: getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: LoadinggScreen());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  String fullName = snapshot.data?['fullName'] ?? 'No full name available';
                  String profilePicUrl = snapshot.data?['profilePicUrl'] ?? '';

                  return Column(
                    children: [
                      CircleAvatar(
                        radius: AppSizes.xxxLarge,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage: profilePicUrl.isNotEmpty
                            ? NetworkImage(profilePicUrl)
                            : null,
                        child: profilePicUrl.isEmpty
                            ? const Icon(
                          Icons.person,
                          size: AppSizes.xxxLarge,
                          color: Colors.grey,
                        )
                            : null,
                      ),
                      const SizedBox(height: 10),
                      // Full name without the GestureDetector
                      Text(
                        fullName,
                        style: const TextStyle(fontSize: AppSizes.xLarge, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: AppSizes.small),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            user.email!,
                            style: const TextStyle(fontSize: AppSizes.medium),
                          ),
                          const SizedBox(width: AppSizes.xSmall),
                          const Icon(Icons.email, size: AppSizes.medium),
                        ],
                      ),
                    ],

                  );

                }
              },
            ),
            const SizedBox(height: AppSizes.medium),
            const Divider(),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.edit_document),
                    title: const Text('Chỉnh sửa trang cá nhân'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(EditProfileScreen.routeName);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.account_balance_wallet),
                    title: const Text('Ví của tôi'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.group),
                    title: const Text('Nhóm'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.book),
                    title: const Text('Sổ nợ'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.support),
                    title: const Text('Hỗ trợ'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Cài đặt'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text('Giới thiệu'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(IntroduceScreen.routeName);
                    },
                  ),
                  FutureBuilder<String>(
                    future: VersionHelper.getAppVersion(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const ListTile(
                          leading: Icon(Icons.verified_user),
                          title: Text('Phiên bản'),
                          trailing: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return const ListTile(
                          leading: Icon(Icons.verified_user),
                          title: Text('Phiên bản'),
                          trailing: Text('Error fetching version'),
                        );
                      } else {
                        return ListTile(
                          leading: const Icon(Icons.verified_user),
                          title: const Text('Phiên bản'),
                          trailing: Text(
                            snapshot.data ?? 'Unknown version',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        );
                      }
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Đăng xuất',),
                    onTap: () => signUserOut(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
