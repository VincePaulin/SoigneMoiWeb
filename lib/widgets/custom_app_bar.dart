import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Welcome',
              style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
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
            child: Padding(
              padding: EdgeInsets.all(8.0),
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
                        'Olivier',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Patient',
                        style: TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.w300),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
