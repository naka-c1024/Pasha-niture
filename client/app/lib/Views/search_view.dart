import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:app/Views/picture_search_view.dart';

// 選択したカテゴリをインデックスで保持
final categoryProvider = StateProvider((ref) => -1);

class SearchView extends HookConsumerWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 8,
          backgroundColor: const Color(0xffffffff),
          title: const TabBar(
            tabs: [
              Tab(
                child: Text(
                  '写真',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'キーワード',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const PictureSearchView(),
            Container(),
          ],
        ),
      ),
    );
  }
}