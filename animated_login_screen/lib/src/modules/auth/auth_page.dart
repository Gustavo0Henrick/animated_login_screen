import 'package:animated_login_screen/src/widgets/wave_clipper.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController _controller;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscure = true;
  bool emailError = false;
  bool passwordError = false;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 6), vsync: this);
    _controller.repeat();

    animation = Tween<double>(begin: -305, end: -78).animate(_controller);

    animation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Container(
          child: Stack(alignment: Alignment.bottomCenter, children: [
            Positioned(
              top: -30,
              right: animation.value,
              child: RotatedBox(
                quarterTurns: 2,
                child: ClipPath(
                  clipper: WaveClipper(),
                  child: Opacity(
                    opacity: 0.5,
                    child: Container(
                      color: Colors.deepOrangeAccent,
                      width: 900,
                      height: 200,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: -30,
              left: animation.value,
              child: RotatedBox(
                quarterTurns: 2,
                child: ClipPath(
                  clipper: WaveClipper(),
                  child: Opacity(
                    opacity: 0.5,
                    child: Container(
                      color: Colors.deepOrange,
                      width: 900,
                      height: 200,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 260,
              child: Container(
                width: size.width,
                child: Column(
                  children: [
                    const Opacity(
                      opacity: 0.75,
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 37,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50, bottom: 30),
                      child: Opacity(
                        opacity: 0.75,
                        child: Container(
                          width: size.width / 1.25,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    emailError ? Colors.red : Colors.deepOrange,
                                width: emailError ? 2 : 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !value.contains('@')) {
                                setState(() {
                                  emailError = true;
                                });
                                return null;
                              } else {
                                setState(() {
                                  emailError = false;
                                });
                                return null;
                              }
                            },
                            cursorHeight: 24,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                fontSize: 22,
                                color: emailError ? Colors.red : Colors.grey,
                              ),
                              prefixIcon: Icon(
                                Icons.email,
                                color:
                                    emailError ? Colors.red : Colors.deepOrange,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: 0.75,
                      child: Container(
                        width: size.width / 1.25,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: passwordError
                                  ? Colors.red
                                  : Colors.deepOrange,
                              width: passwordError ? 2 : 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 6) {
                              setState(() {
                                passwordError = true;
                              });
                              return null;
                            } else {
                              setState(() {
                                passwordError = false;
                              });
                              return null;
                            }
                          },
                          obscureText: obscure,
                          cursorHeight: 24,
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              fontSize: 22,
                              color: passwordError ? Colors.red : Colors.grey,
                            ),
                            prefixIcon: Icon(
                              Icons.vpn_key,
                              color: passwordError
                                  ? Colors.red
                                  : Colors.deepOrange,
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    obscure = !obscure;
                                  });
                                },
                                child: Icon(
                                  obscure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  size: 27,
                                  color: passwordError ? Colors.red : null,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 540,
              child: Container(
                width: size.width,
                child: Column(
                  children: [
                    Opacity(
                      opacity: 0.75,
                      child: Container(
                        height: 50,
                        width: size.width / 1.25,
                        child: ElevatedButton(
                          onPressed: loading
                              ? null
                              : () async {
                                  setState(() {
                                    loading = true;
                                    print(loading);
                                  });
                                  await Future.delayed(Duration(seconds: 2));
                                  setState(() {
                                    loading = false;
                                    print(loading);
                                  });
                                  if (_formKey.currentState!.validate()) {
                                    if (!emailError && !passwordError) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 30),
                                            child: Text('Login Successfully'),
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15))),
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 30),
                                            child: Text('Login Error'),
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15))),
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 30),
                                          child: Text('Login Error'),
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  }
                                },
                          child: loading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.deepOrange,
                                  ),
                                )
                              : const Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                          style: ElevatedButton.styleFrom(
                            onSurface: Colors.deepOrange,
                            shadowColor: Colors.deepOrange,
                            onPrimary: Colors.deepOrange,
                            primary: Colors.deepOrange,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: -60,
              right: animation.value,
              child: ClipPath(
                clipper: WaveClipper(),
                child: Opacity(
                  opacity: 0.5,
                  child: Container(
                    color: Colors.deepOrangeAccent,
                    width: 900,
                    height: 200,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -60,
              left: animation.value,
              child: ClipPath(
                clipper: WaveClipper(),
                child: Opacity(
                  opacity: 0.5,
                  child: Container(
                    color: Colors.deepOrange,
                    width: 900,
                    height: 200,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
