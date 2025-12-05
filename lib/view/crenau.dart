import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ViewModele/parametrage_view_model.dart';
import '../modele/crenau_modele.dart';

class ParametrageView extends StatelessWidget {
  const ParametrageView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ParametrageViewModel(),
      child: const _ParametrageBody(),
    );
  }
}

class _ParametrageBody extends StatelessWidget {
  const _ParametrageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ParametrageViewModel>();

    if (vm.loading) return const Center(child: CircularProgressIndicator());
    if (vm.error != null) return Center(child: Text(vm.error!));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Réserver un créneau",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
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
        child: Column(
          children: [
            DropdownButton<Pro>(
              hint: const Text("Choisir un docteur"),
              value: vm.selectedPro,
              onChanged: vm.selectPro,
              items: vm.pros.map((pro) {
                return DropdownMenuItem(
                  value: pro,
                  child: Text(pro.fullName),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            if (vm.selectedPro != null)
              Expanded(
                child: ListView.builder(
                  itemCount: vm.selectedPro!.crenaux.length,
                  itemBuilder: (context, index) {
                    final c = vm.selectedPro!.crenaux[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              c.description,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Début : ${c.dateDebut.day}/${c.dateDebut.month}/${c.dateDebut.year} ${c.dateDebut.hour}:${c.dateDebut.minute.toString().padLeft(2, '0')}",
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 14),
                            ),
                            Text(
                              "Fin : ${c.dateFin.day}/${c.dateFin.month}/${c.dateFin.year} ${c.dateFin.hour}:${c.dateFin.minute.toString().padLeft(2, '0')}",
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 14),
                            ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                onPressed: () {
                                  vm.createAppointment(c.id, context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff6471EE),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text("Réserver"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
