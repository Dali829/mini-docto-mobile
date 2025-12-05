import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ViewModele/mes_rendezvous_viewmodel.dart';

class MesRendezVousPage extends StatelessWidget {
  const MesRendezVousPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MesRendezVousViewModel(),
      child: const _MesRendezVousBody(),
    );
  }
}

class _MesRendezVousBody extends StatelessWidget {
  const _MesRendezVousBody({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MesRendezVousViewModel>();

    if (vm.loading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    if (vm.error != null) {
      return Center(
        child: Text(
          "Erreur : ${vm.error}",
          style: const TextStyle(color: Colors.redAccent, fontSize: 16),
        ),
      );
    }

    if (vm.appointments.isEmpty) {
      return const Center(
        child: Text(
          "Aucun rendez-vous",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Mes rendez-vous",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 100),
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
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: vm.appointments.length,
          itemBuilder: (context, index) {
            final rdv = vm.appointments[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Date : ${rdv.dateReservation.day}/${rdv.dateReservation.month}/${rdv.dateReservation.year}",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Heure : ${rdv.dateReservation.hour}h${rdv.dateReservation.minute.toString().padLeft(2, '0')}",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Créneau début: ${rdv.creneauId.dateDebut}",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  Text(
                    "Créneau fin: ${rdv.creneauId.dateFin}",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 10),
                  (rdv.statut.toString() != "annuler par client")
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () => vm.cancelAppointment(rdv.id),
                            child: const Text(
                              "Annuler",
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        )
                      : Text(rdv.statut.toString())
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
