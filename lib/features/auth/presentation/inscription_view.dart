import 'package:flutter/material.dart';

import '../../../utils/app_text_styles.dart';
import '../../../utils/gradient_button.dart';
import '../data/datasources/signup_remote_datasource.dart';
import '../data/repositories/signup_repository_impl.dart';
import '../domain/entities/user_entity.dart';
import '../domain/usecases/signup_usecase.dart';
import 'connexion_view.dart';

class InscriptionView extends StatefulWidget {
  const InscriptionView({super.key});

  @override
  State<InscriptionView> createState() => _InscriptionViewState();
}

class _InscriptionViewState extends State<InscriptionView> {
  final _formKey = GlobalKey<FormState>();

  final nom = TextEditingController();
  final prenom = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  bool loading = false;
  String? errorMessage;

  late final SignupUseCase signupUseCase;

  @override
  void initState() {
    super.initState();

    final dataSource = SignupRemoteDataSourceImpl(
      "http://localhost:8800/api",
    );

    final repo = SignupRepositoryImpl(dataSource);

    signupUseCase = SignupUseCase(repo);
  }

  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
        errorMessage = null;
      });

      final user = UserEntity(
        nom: nom.text.trim(),
        prenom: prenom.text.trim(),
        email: email.text.trim(),
        password: password.text.trim(),
      );

      try {
        await signupUseCase(user);

        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ConnexionView()),
        );
      } catch (e) {
        setState(() => errorMessage = e.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorMessage ?? "Failed")));
      }

      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Text(
                    "INSCRIPTION",
                    style: AppTextStyle.h1.copyWith(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                              controller: nom,
                              decoration: const InputDecoration(
                                labelText: 'Nom',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'nom est obligatoire';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                              controller: prenom,
                              decoration: const InputDecoration(
                                labelText: 'Prénom',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'prénom est obligatoire';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                              controller: email,
                              decoration: const InputDecoration(
                                labelText: 'E-mail',
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'E-mail est obligatoire';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                              controller: password,
                              decoration: const InputDecoration(
                                labelText: 'Mot de passe',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'mot de passe est obligatoire';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 30,
                          ),
                          loading
                              ? const CircularProgressIndicator()
                              : GradientButton(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xffFFA156),
                                      Color(0xffFF6600),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  text: "Inscription",
                                  onTap: _signup,
                                ),
                        ],
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "J’AI UN COMPTE !",
                    style: AppTextStyle.h1
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: GradientButton(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xff02CEE1),
                          Color(0xff4437AF),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      text: "CONNEXION",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ConnexionView()),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
