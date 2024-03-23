import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.green[200],
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/iconLogin.png',
                  height: deviceHeight * 0.40,
                  width: deviceWidth,
                )
              ],
            ),
          ),
          Expanded(
            flex: 60,
            child: Container(
              width: deviceWidth,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Selamat Datang',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    const Text(
                      'Silahkan mengisi form login terlebih dahulu untuk menikmati fasilitas kami',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 17,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            TextFormField(
                              // maxLength: 20,
                              decoration: const InputDecoration(
                                  labelText: 'Email or Username',
                                  hintText: 'Enter your email or username',
                                  border: OutlineInputBorder()),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              obscureText: !_passwordVisible,
                              validator: (String? value) {
                                return (value != null && value.length < 8)
                                    ? 'Please enter at least 8 characters.'
                                    : null;
                              },
                              decoration: InputDecoration(
                                // hintText: 'What do people call you?',
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                suffixIcon: IconButton(
                                  icon: _passwordVisible
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: deviceHeight * 0.06,
                              child: ElevatedButton(
                                onPressed: () {
                                  print('nice');
                                },
                                child: const Text(
                                  "Log in",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey,
                                    height: 36,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Text(
                                    'OR',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey,
                                    height: 36,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: deviceHeight * 0.06,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[
                                        100], // Atur warna latar belakang menjadi putih
                                  ),
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Google',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Image.asset(
                                        'assets/googleIcon.png',
                                        width: 22,
                                        height: 22,
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
