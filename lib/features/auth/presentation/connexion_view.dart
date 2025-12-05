import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_text_styles.dart';
import '../data/datasources/signin_remote_datasource.dart';
import '../data/repositories/signin_repository_impl.dart';
import '../domain/entities/signin_entity.dart';
import '../domain/usecases/sihnin_usecase.dart';
import '../../../utils/gradient_button.dart';
import 'inscription_view.dart';
import '../../../view/menu_view.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class ConnexionView extends StatefulWidget {
  final FirebaseAnalytics? analytics;

  const ConnexionView({super.key,  this.analytics});

  @override
  State<ConnexionView> createState() => _ConnexionViewState();
}

class _ConnexionViewState extends State<ConnexionView> {
  final _formKey = GlobalKey<FormState>();

  final email = TextEditingController();
  final password = TextEditingController();

  bool loading = false;
  String? errorMessage;

  late final LoginUseCase loginUseCase;
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    super.initState();

    final datasource = LoginRemoteDataSourceImpl(
      "http://localhost:8800/api",
    );

    final repo = LoginRepositoryImpl(datasource);

    loginUseCase = LoginUseCase(repo);
  }

  Future<void> _login() async {
    await analytics.logEvent(name: "app_opened");
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
        errorMessage = null;
      });

      final user = LoginEntity(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      try {
        final data = await loginUseCase(user);
        final token = data['token'];

        if (token != null) {
          await storage.write(key: "token", value: token);
        }

        if (!mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Bienvenue !")));

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ModePseudoView()),
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "MINI-DOCTOR +",
                  style: AppTextStyle.h1
                      .copyWith(fontSize: 24, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            obscureText: true,
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
                        GradientButton(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xffFFA156),
                                Color(0xffFF6600),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            text: "CONNEXION",
                            onTap: _login),
                      ],
                    )),
              ],
            ),
            Column(
              children: [
                Text(
                  "JE N’AI PAS DE COMPTE !",
                  style: AppTextStyle.h1
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 15,
                ),
                GradientButton(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff02CEE1),
                      Color(0xff4437AF),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  text: "INSCRIPTION",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InscriptionView()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
