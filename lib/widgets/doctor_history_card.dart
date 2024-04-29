import 'package:flutter/material.dart';
import 'package:soigne_moi_web/model/doctor.dart';

class DoctorHistoryCard extends StatefulWidget {
  final List<Doctor> doctors;

  const DoctorHistoryCard({super.key, required this.doctors});

  @override
  State<DoctorHistoryCard> createState() => _DoctorHistoryCardState();
}

class _DoctorHistoryCardState extends State<DoctorHistoryCard> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(8.0),
      color: Colors.white.withOpacity(0.8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Docteurs vus',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          if (widget.doctors.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Vous n'avez pas encore eu de docteur"),
            ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    _scrollOffset -= 200;
                    _scrollController.animateTo(
                      _scrollOffset,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: _scrollController,
                        itemCount: widget.doctors.length,
                        itemBuilder: (context, index) {
                          final doctor = widget.doctors[index];
                          return DoctorCard(
                            doctor: doctor,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    _scrollOffset += 200;
                    _scrollController.animateTo(
                      _scrollOffset,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.lightBlue[100],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, size: 30, color: Colors.white),
            ),
            const SizedBox(height: 5),
            Text(
              doctor.fullName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
