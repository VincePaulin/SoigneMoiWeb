import 'package:flutter/material.dart';
import 'package:soigne_moi_web/model/stay.dart';
import 'package:soigne_moi_web/utils/app_fonts.dart';
import 'package:soigne_moi_web/widgets/custom_list_tile.dart';
import 'package:soigne_moi_web/widgets/empty_stay.dart';

class HomePageBody extends StatelessWidget {
  final List<Stay> stays;
  const HomePageBody({super.key, required this.stays});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    List<Stay> ongoingStays = stays.where((stay) {
      return stay.startDate.isAtSameMomentAs(now) ||
          stay.startDate.isBefore(now) && stay.endDate.isAfter(now);
    }).toList();

    List<Stay> upcomingStays = stays.where((stay) {
      return stay.startDate.isAfter(now);
    }).toList();

    List<Stay> pastStays = stays.where((stay) {
      return stay.endDate.isBefore(now) && stay.endDate.isBefore(now);
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 5,
                    color: Colors.white.withOpacity(0.8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Séjour en cours',
                            style: montserratTextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ongoingStays.isEmpty
                              ? const EmptyListStay()
                              : ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: ongoingStays.length,
                                  itemBuilder: (context, index) {
                                    Stay stay = ongoingStays[index];
                                    return CustomListTile(stay: stay);
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 5,
                    color: Colors.white.withOpacity(0.8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Séjour(s) à venir',
                            style: montserratTextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: upcomingStays.isEmpty
                              ? const EmptyListStay()
                              : ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: upcomingStays.length,
                                  itemBuilder: (context, index) {
                                    final stay = upcomingStays[index];
                                    return CustomListTile(stay: stay);
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Card(
              elevation: 5,
              color: Colors.white.withOpacity(0.8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Historique des Séjours',
                      style: montserratTextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: pastStays.isEmpty
                        ? const EmptyListStay()
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: pastStays.length,
                            itemBuilder: (context, index) {
                              final stay = pastStays[index];
                              return CustomListTile(stay: stay);
                            },
                          ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
