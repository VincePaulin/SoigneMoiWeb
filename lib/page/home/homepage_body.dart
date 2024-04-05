import 'package:flutter/material.dart';
import 'package:soigne_moi_web/model/stay.dart';
import 'package:soigne_moi_web/widgets/custom_list_tile.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Séjour en cours',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return CustomListTile(
                                stay: Stay(
                                  title: 'Séjour ${index + 1}',
                                  type: 'Type A',
                                  date: DateTime.now(),
                                  endDate:
                                      DateTime.now().add(Duration(days: 7)),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Séjour(s) à venir',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return CustomListTile(
                                stay: Stay(
                                  title: 'Séjour ${index + 3}',
                                  type: 'Type B',
                                  date: DateTime.now().add(Duration(days: 10)),
                                  endDate:
                                      DateTime.now().add(Duration(days: 17)),
                                ),
                              );
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
          SizedBox(height: 20),
          Expanded(
            child: Card(
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Historique des Séjours',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return CustomListTile(
                          stay: Stay(
                            title: 'Séjour ${index + 5}',
                            type: 'Type C',
                            date: DateTime.now().add(Duration(days: 20)),
                            endDate: DateTime.now().add(Duration(days: 27)),
                          ),
                        );
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
