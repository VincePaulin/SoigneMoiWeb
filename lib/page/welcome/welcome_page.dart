import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soigne_moi_web/config/app_config.dart';
import 'package:soigne_moi_web/model/medical_section.dart';
import 'package:soigne_moi_web/utils/app_fonts.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppConfig.applicationName,
              style: robotoTextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(
              width: 2.0,
            ),
            Image.asset('assets/img/logo.png', height: 50),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Section du haut
            Container(
              color: Colors.white,
              child: SizedBox(
                height: 500,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/img/welcome.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Laissez-nous vous aider',
                            style: robotoTextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Inscrivez-vous et demander un séjour",
                            style: robotoTextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context.go('/login');
                            },
                            child: Text('Login',
                                style: robotoTextStyle(fontSize: 18)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                children: [
                  Text(
                    'Bienvenue à Soigne Moi',
                    style: robotoTextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Soigne Moi est un établissement de santé de premier plan, '
                    'offrant une large gamme de services médicaux et chirurgicaux. '
                    'Nos équipes de professionnels de la santé sont dédiées à fournir '
                    'des soins de haute qualité et à améliorer la vie de nos patients.',
                    textAlign: TextAlign.center,
                    style: robotoTextStyle(),
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 6 / 2,
                    ),
                    itemCount: medicalSections.length,
                    itemBuilder: (context, index) {
                      final section = medicalSections[index];
                      return Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                section.name,
                                style: robotoTextStyle(
                                  fontSize: 18, // Reduced font size
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ...section.departments.map((department) {
                                return Text(
                                  '- $department',
                                  style: robotoTextStyle(
                                      fontSize: 14,
                                      color: Colors
                                          .grey[700]!), // Reduced font size
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
