import 'package:flutter/material.dart';
import 'package:pengajuan_judul_dashboard/app/app.router.dart';
import 'package:pengajuan_judul_dashboard/app/themes/app_colors.dart';
import 'package:pengajuan_judul_dashboard/app/themes/app_text.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:unicons/unicons.dart';

import './dashboard_view_model.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const iconThemeData = IconThemeData(
      color: Colors.white,
    );

    final selectedLabelTextStyle =
        regularTextStyle.copyWith(color: Colors.white);
    final unselectedLabelTextStyle =
        regularTextStyle.copyWith(color: Colors.white70);

    return ViewModelBuilder<DashboardViewModel>.reactive(
      viewModelBuilder: () => DashboardViewModel(),
      builder: (
        BuildContext context,
        DashboardViewModel model,
        Widget? child,
      ) {
        return ResponsiveBuilder(builder: (context, sizingInformation) {
          return Scaffold(
            body: Row(
              children: [
                if (!sizingInformation.isMobile)
                  NavigationRail(
                    selectedIndex: model.currentIndex,
                    onDestinationSelected: model.handleNavigation,
                    backgroundColor: secondaryColor,
                    indicatorColor: mainColor,
                    useIndicator: true,
                    extended: true,
                    minExtendedWidth: 150,
                    selectedIconTheme: iconThemeData,
                    unselectedIconTheme: iconThemeData,
                    selectedLabelTextStyle: selectedLabelTextStyle,
                    unselectedLabelTextStyle: unselectedLabelTextStyle,
                    destinations: model.items
                        .map((item) => NavigationRailDestination(
                              icon: Icon(item['icon']),
                              label: Text(item['label']),
                            ))
                        .toList(),
                    leading: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Column(
                        children: [
                          Image.asset('assets/images/logo.png', width: 60),
                          const SizedBox(height: 8),
                          Text(
                            "UM-Parepare",
                            style: regularTextStyle.copyWith(
                                color: fontSecondaryColor),
                          ),
                        ],
                      ),
                    ),
                    trailing: Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Spacer(),
                          TextButton.icon(
                            onPressed: model.onLogout,
                            icon: const Icon(
                              UniconsLine.sign_out_alt,
                              color: fontSecondaryColor,
                              size: 20,
                            ),
                            label: Text(
                              "Keluar",
                              style: regularTextStyle.copyWith(
                                color: fontSecondaryColor,
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: ExtendedNavigator(
                          router: DashboardViewRouter(),
                          navigatorKey: StackedService.nestedNavigationKey(1),
                        ),
                      ),
                      const Text("Teknik Informatika - UM Parepare © 2022"),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: !sizingInformation.isMobile
                ? null
                : BottomNavigationBar(
                    currentIndex: model.currentIndex,
                    onTap: model.handleNavigation,
                    unselectedItemColor: fontSecondaryColor,
                    items: model.items
                        .map((item) => BottomNavigationBarItem(
                              icon: Icon(item['icon']),
                              label: item['label'],
                              backgroundColor: secondaryColor,
                            ))
                        .toList(),
                  ),
          );
        });
      },
    );
  }
}
