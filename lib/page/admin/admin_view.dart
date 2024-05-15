import 'package:flutter/material.dart';
import 'package:soigne_moi_web/page/admin/agendas/agendas.dart';
import 'package:soigne_moi_web/utils/screen_size.dart';
import 'package:soigne_moi_web/widgets/admin_app_bar.dart';
import 'package:soigne_moi_web/widgets/admin_navigation_bar.dart';
import 'package:soigne_moi_web/widgets/navigation_bar.dart';
import 'doctors/doctors.dart';

class AdminView extends StatefulWidget {
  final int? index;
  const AdminView({super.key, this.index});

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.index != null && widget.index! >= 0 && widget.index! <= 3) {
      setState(() {});
      _selectedIndex = widget.index!;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String getPageName(int index) {
    switch (index) {
      case 0:
        return "Planings";
      case 1:
        return 'Docteurs';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = ScreenSizeUtil.isSmallScreen(context);

    return Scaffold(
      body: Column(
        children: [
          const AdminAppBar(),
          Expanded(
              child: Row(
            children: [
              !isSmallScreen
                  ? AdminNavBar(
                      selectedIndex: _selectedIndex,
                      onItemTapped: _onItemTapped,
                    )
                  : Container(),
              Expanded(
                child: IndexedStack(
                  index: _selectedIndex,
                  children: [
                    AdminAgendas(),
                    AdminDoctors(),
                  ],
                ),
              )
            ],
          ))
        ],
      ),
      drawer: isSmallScreen
          ? NavBar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            )
          : null,
    );
  }
}

// Todo: make setting page simply
