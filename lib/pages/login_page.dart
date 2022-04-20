import 'package:active_tourist_app/pages/register_page.dart';
import 'package:active_tourist_app/manager/service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginPageSate();
}

class LoginPageSate extends State<LoginPage> {
  TextEditingController loginController = TextEditingController();
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
                "Вход",
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
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(232, 222, 248, 1)),
                  fixedSize: MaterialStateProperty.all<Size>(const Size(400, 48)),
                ),
                onPressed: () {
                  Service().login(loginController.text, passwordController.text, context);
                },
                child: Text("Войти", style: GoogleFonts.manrope(
                  color: Colors.black
                ),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(232, 222, 248, 1)),
                      fixedSize: MaterialStateProperty.all<Size>(const Size(120, 48)),
                    ),
                    onPressed: () {},
                    child: Text("Vk", style: GoogleFonts.manrope(
                        color: Colors.black
                    ),),
                  ),
                  TextButton(
                    onPressed: (){},
                    child: Text("Забыли пароль?", style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: const Color.fromRGBO(152, 150, 244, 1),
                      decoration: TextDecoration.underline,
                    ),),
                  )
                ],
              ),
              TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
                },
                child: Text("Еще не зарегестрированы?", style: GoogleFonts.manrope(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: const Color.fromRGBO(152, 150, 244, 1),
                  decoration: TextDecoration.underline,
                ),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
