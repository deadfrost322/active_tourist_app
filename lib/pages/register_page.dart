import 'package:active_tourist_app/manager/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  TextEditingController loginController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;

  setObscure() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 65, 16, 200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Регистрация",
                style: GoogleFonts.manrope(
                    fontSize: 24, fontWeight: FontWeight.w400),
              ),
              TextFormField(
                style: GoogleFonts.manrope(),
                controller: loginController,
                decoration: const InputDecoration(
                  focusColor: Color(0xFF6200EE),
                  hintText: 'Login',
                  labelText: 'Login',
                  helperText: "*Обязательное поле",
                  border: OutlineInputBorder(),
                ),
              ),
              TextFormField(
                style: GoogleFonts.manrope(),
                controller: emailController,
                decoration: const InputDecoration(
                  focusColor: Color(0xFF6200EE),
                  hintText: 'Email',
                  labelText: 'Email',
                  helperText: "*Обязательное поле",
                  border: OutlineInputBorder(),
                ),
              ),
              TextFormField(
                style: GoogleFonts.manrope(),
                controller: passwordController,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                    hintText: 'Password',
                    labelText: 'Password',
                    helperText: "*Обязательное поле",
                    border: const OutlineInputBorder(),
                    suffixIcon: InkWell(
                        onTap: () {
                          setObscure();
                        },
                        child: Icon(
                          obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.black,
                        ))),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromRGBO(232, 222, 248, 1)),
                  fixedSize: MaterialStateProperty.all<Size>(
                      const Size(400, 48)),
                ),
                onPressed: () {Service().registration(loginController.text, emailController.text, passwordController.text, context);},
                child: Text("Зарегистрироваться", style: GoogleFonts.manrope(
                    color: Colors.black
                ),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(232, 222, 248, 1)),
                      fixedSize: MaterialStateProperty.all<Size>(
                          const Size(120, 48)),
                    ),
                    onPressed: () {},
                    child: Text("Vk", style: GoogleFonts.manrope(
                        color: Colors.black
                    ),),
                  ),
                  TextButton(
                    onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));},
                    child: Text("Уже есть аккаунт?", style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: const Color.fromRGBO(152, 150, 244, 1),
                      decoration: TextDecoration.underline,
                    ),),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}