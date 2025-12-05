import 'package:flutter/material.dart';

import '../features/auth/presentation/connexion_view.dart';
import '../utils/gradient_button.dart';
import 'crenau.dart';
import 'mes_rendez-vous.dart';

class ModePseudoView extends StatefulWidget {
  const ModePseudoView({super.key});

  @override
  State<ModePseudoView> createState() => _ModePseudoViewState();
}

class _ModePseudoViewState extends State<ModePseudoView> {
  Future<void> logout() async {
    await storage.deleteAll();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff6471EE),
              Color(0xff491D7F),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              GradientButton(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff02CEE1),
                    Color(0xff4437AF),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                text: "Réserver un créneau horaire",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ParametrageView()),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              GradientButton(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff107C10),
                    Color(0xff1DE21D),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                text: "Consulter ses rendez-vous",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MesRendezVousPage()),
                ),
              ),

              const SizedBox(
                height: 40,
              ),
              GradientButton(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff107C10),
                    Color(0xff1DE21D),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                text: "Déconnecter",
                onTap: () => {
                  logout(),
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ConnexionView()),
                )},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
