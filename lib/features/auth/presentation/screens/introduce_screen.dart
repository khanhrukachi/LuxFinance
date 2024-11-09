import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:personal_financial_management/core/constants/app_colors.dart';
import 'package:personal_financial_management/core/constants/app_image.dart';
import 'package:personal_financial_management/core/constants/app_sizes.dart';

class IntroduceScreen extends StatelessWidget {
  static const routeName = '/introduce';

  const IntroduceScreen({super.key});

  Future<String> _getAppVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: const Text('Giới thiệu'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // This will navigate back to the previous screen
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.medium),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.logoFinancialManagementIcon,
                height: AppSizes.xxxLarge * 3,
                width: AppSizes.xxxLarge * 3,
              ),
              const SizedBox(height: AppSizes.large),
              const Text(
                'LuxFinance',
                style: TextStyle(
                  fontSize: AppSizes.xxLarge,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackColor,
                ),
              ),
              const SizedBox(height: AppSizes.xSmall),
              FutureBuilder<String>(
                future: _getAppVersion(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text('Error loading version');
                  } else {
                    return Text(
                      'Phiên bản ${snapshot.data}',
                      style: const TextStyle(
                        fontSize: AppSizes.medium,
                        color: Colors.grey,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: AppSizes.xSmall),
              const Text(
                '****************',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: AppSizes.large),
              Container(
                color: AppColors.realWhiteColor,
                child: Column(
                  children: [
                    const SizedBox(height: AppSizes.large),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildIconText2(Icons.menu_book, 'Hướng dẫn'),
                        Container(
                          width: 1,
                          height: 40,
                          color: Colors.grey,
                        ),
                        _buildIconText2(Icons.help_outline, 'Hỗ trợ'),
                      ],
                    ),
                    const SizedBox(height: AppSizes.xxxLarge),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSizes.xxxLarge * 2),
                      child: Column(
                        children: [
                          _buildIconText(Icons.facebook, 'Theo dõi chúng tôi trên Facebook'),
                          const SizedBox(height: AppSizes.large),
                          _buildIconText(Icons.group, 'Tham gia nhóm dùng thử'),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSizes.large),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.large),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bản quyền thuộc về Finsify ',
                    style: TextStyle(fontSize: AppSizes.xxSmall, color: Colors.grey),
                  ),
                  Icon(Icons.copyright, size: AppSizes.medium, color: Colors.grey),
                  Text(
                    ' 2024.',
                    style: TextStyle(fontSize: AppSizes.xxSmall, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconText(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 30,
          color: AppColors.blueColor,
        ),
        const SizedBox(width: AppSizes.xSmall),
        Expanded(
          child: Text(
            text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: AppSizes.xxSmall,
              color: AppColors.blackColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIconText2(IconData icon, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 30,
          color: AppColors.blueColor,
        ),
        const SizedBox(height: AppSizes.xSmall),
        Text(
          text,
          style: const TextStyle(
            fontSize: AppSizes.medium,
            color: AppColors.blackColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
