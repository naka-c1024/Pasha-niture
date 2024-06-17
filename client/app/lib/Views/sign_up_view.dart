import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:app/constants.dart';

class SignUpView extends HookConsumerWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userNameController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');
    final selectedPrefecture = useState<int>(12); // デフォルトは東京
    
    return Scaffold(
      appBar: AppBar(),
      body: Container(
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
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
