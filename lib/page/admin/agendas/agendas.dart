import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soigne_moi_web/function/admin_api.dart';
import 'package:soigne_moi_web/model/agenda.dart';

import 'agendasListView.dart';

class AdminAgendas extends StatefulWidget {
  const AdminAgendas({super.key});

  @override
  AgendasController createState() => AgendasController();
}

class AgendasController extends State<AdminAgendas> {
  List<Agenda> agendasList = [];

  @override
  void initState() {
    super.initState();
    fetchAgendas(); // Calling the method to retrieve agendas
  }

  void fetchAgendas() async {
    try {
      List<Agenda>? agendas = await AdminApi().fetchAllAgendas();
      setState(() {
        agendasList = agendas!;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Failed to fetch agendas: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AgendasListView(
      controller: this,
    );
  }
}
