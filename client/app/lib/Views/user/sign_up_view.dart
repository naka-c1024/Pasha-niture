// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Domain/constants.dart';
import '../common/error_dialog.dart';
import 'login_view.dart';

class SignUpView extends HookConsumerWidget {
  final CameraDescription? camera;
  const SignUpView({super.key, required this.camera});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userNameController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');
    final selectedPrefecture = useState<int>(12); // デフォルトは東京

    Future<void> isSignUpSuccessfully() async {
      final url = Uri.parse('http://$ipAddress:8080/sign_up');
      final headers = {'Content-Type': 'application/json'};
      final requestBody = jsonEncode({
        'username': userNameController.text,
        'password': passwordController.text,
        'area': selectedPrefecture.value,
      });
      try {
        final response =
            await http.post(url, headers: headers, body: requestBody);
        if (response.statusCode == 200) {
          // ログイン画面へ
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginView(camera: camera),
            ),
          );
          // ユーザーネームとアドレスをデバイスに保存
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('userName', userNameController.text);
          await prefs.setInt('address', selectedPrefecture.value);
        } else {
          final jsonResponse = jsonDecode(response.body);
          final message = jsonResponse['detail'];
          showErrorDialog(context, message);
        }
      } catch (e) {
        showErrorDialog(context, e.toString());
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Text('ユーザー名'),
              TextField(
                controller: userNameController,
                onSubmitted: (String value) {
                  userNameController.text = value;
                },
              ),
              const SizedBox(height: 24),
              const Text('パスワード'),
              TextField(
                controller: passwordController,
                obscureText: true,
                keyboardType: TextInputType.text,
                onSubmitted: (String value) {
                  passwordController.text = value;
                },
              ),
              const SizedBox(height: 24),
              const Text('お住まいの都道府県'),
              DropdownButton(
                isExpanded: true,
                menuMaxHeight: 240,
                value: prefectures[selectedPrefecture.value],
                items: prefectures.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String? value) {
                  selectedPrefecture.value = prefectures.indexOf(value!);
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.black,
                ),
                onPressed: () async {
                  if (userNameController.text == '') return;
                  isSignUpSuccessfully();
                },
                child: Container(
                  height: 40,
                  width: 80,
                  alignment: Alignment.center,
                  child: const Text(
                    '登録',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
