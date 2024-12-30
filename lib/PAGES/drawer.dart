// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

import '../WIDGETS/drawerlist.dart';
import '../Widgets/colors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final double _devWidth = MediaQuery.of(context).size.width;
    final double _devHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        width: _devWidth * 0.8,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: CustomColors.orange,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                       CircleAvatar(
                        radius: 32,
                        backgroundColor:
                            //userController.profileImage.value != null
                                // ? Colors.transparent
                                 CustomColors.fadeOrange,
                        child: 
                        //userController.profileImage.value != null
                             CircleAvatar(
                                radius: 30,
                                backgroundColor: CustomColors.fadeOrange,
                                child: Icon(Icons.person,
                                    size: 30,
                                    color: Colors
                                        .white), // Optional: Add a default icon
                              ),
                      ),
                    SizedBox(width: _devWidth * 0.04),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                       Text(
                            "Name",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: Colors.grey.shade300,
                                  fontSize: 18,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        SizedBox(height: _devHeight * 0.01),
                          Text(
                           "+254********90",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey.shade300,
                                  fontSize: 18,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        SizedBox(height: _devHeight * 0.01),
                         Text(
                            "email@example.com",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  color: Colors.grey.shade300,
                                  fontSize: 18,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              ...List.generate(
                drawerItems.length - 1,
                (index) => GestureDetector(
                  onTap: () {
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          drawerItems[index]["image"]!,
                          width: 24,
                          height: 24,
                        ),
                        SizedBox(width: _devWidth * 0.04),
                        Text(
                          drawerItems[index]["label"].toString(),
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                color: CustomColors.blue,
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: _devHeight * 0.03),
              GestureDetector(
                onTap: () {
                  // userController.logout();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(drawerItems.last["image"]!),
                        SizedBox(width: _devWidth * 0.04),
                        Text(
                          drawerItems.last["label"].toString(),
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                color: CustomColors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
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
      ),
    );
  }
}
