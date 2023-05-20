import 'package:class11ddcontactapp/auth_prefs.dart';
import 'package:class11ddcontactapp/page/contact_list_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.email)
                ),
              ),
              const SizedBox(height: 10,),
              TextField(
                controller: passwordController,
                obscureText: isObscure,
                decoration:  InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                      icon: Icon(isObscure? Icons.visibility_off : Icons.visibility),
                      onPressed: (){
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                  )

                ),
              ),
              const SizedBox(height: 20,),
              TextButton(
                  onPressed: (){
                    setLoginStatus(true)
                        .then((value) => Navigator.pushReplacementNamed(
                        context, ContactList.routeName));
                  },
                  child: Text('Login'))
            ],
          ),
        ),
      ),
    );
  }
}

