import 'package:flutter/material.dart';
import 'package:soigne_moi_web/model/user.dart';
import 'package:soigne_moi_web/utils/app_fonts.dart';
import 'package:soigne_moi_web/utils/screen_size.dart';

class CustomAppBar extends StatelessWidget {
  final String titlePage;
  final User user;
  const CustomAppBar({super.key, required this.titlePage, required this.user});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = ScreenSizeUtil.isSmallScreen(context);

    return Row(
      children: [
        isSmallScreen
            ? IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              )
            : Container(),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    titlePage,
                    style: montserratTextStyle(
                        fontSize: 32.0, fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                  onTap: () {
                    //Todo: make dropdown item notification
                  },
                  borderRadius: BorderRadius.circular(10.0),
                  child: const Icon(
                    Icons.notifications,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                InkWell(
                  onTap: () {
                    // Todo: make dropdown item
                  },
                  borderRadius: BorderRadius.circular(10.0),
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            child: Text('A'),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Column(
                            children: [
                              Text(
                                '${user.firstName} ${user.name}',
                                style: montserratTextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Patient',
                                style: montserratTextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
