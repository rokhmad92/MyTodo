import 'package:flutter/material.dart';
import '../pages/home.dart';
import '../services_Online/auth_service.dart';
import '../services_Offline/auth_service.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  String? email;
  String? password;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  Future<void> doLogin(context) async {
    if (_formKey.currentState!.validate()) {
      AuthService authService = AuthService();
      bool loginSuccess = await authService.login(email!, password!);

      if (!loginSuccess) {
        loginFail();
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Home(),
            ));
      }
    }
  }

  Future<void> doLoginOffline(context) async {
    AuthServiceOffline authServiceOffline = AuthServiceOffline();
    bool loginSuccess = await authServiceOffline.login();

    if (!loginSuccess) {
      loginFail();
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ));
    }
  }

  comingSoon() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Coming Soon...'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  loginFail() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Gagal Login!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.green[400],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: deviceHeight * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/iconLogin.png',
                    height: deviceHeight * 0.4,
                    width: deviceWidth,
                  )
                ],
              ),
            ),
            Container(
              width: deviceWidth,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Selamat Datang',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    const Text(
                      'Silahkan mengisi form login terlebih dahulu untuk menikmati fasilitas kami',
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
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
                        padding: EdgeInsets.symmetric(
                          horizontal: deviceWidth * 0.05,
                        ),
                        child: Column(
                          children: [
                            TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  email = value;
                                });
                              },
                              validator: (value) {
                                return (value == null || value.isEmpty)
                                    ? 'Email is required'
                                    : null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                hintText: 'Enter your email',
                                border: OutlineInputBorder(),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 9,
                                  vertical: 15,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  password = value;
                                });
                              },
                              obscureText: !_passwordVisible,
                              validator: (String? value) {
                                return (value != null && value.length < 8)
                                    ? 'Please enter at least 8 characters.'
                                    : null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
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
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 9,
                                  vertical: 15,
                                ),
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
                                  doLogin(context);
                                },
                                child: const Text(
                                  "Log in",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: deviceHeight * 0.06,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                                onPressed: () => {doLoginOffline(context)},
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Tanpa Login',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: deviceHeight * 0.06,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[50],
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Colors.grey.shade100,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                                onPressed: () => {comingSoon()},
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Daftar Akun',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
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
                                  backgroundColor: Colors.grey[50],
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Colors.grey.shade100,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                                onPressed: () => {comingSoon()},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/googleIcon.png',
                                      width: 22,
                                      height: 22,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text(
                                      'Google',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
