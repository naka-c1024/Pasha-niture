import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'picture_search_view.dart';
import 'keyword_search_view.dart';
import 'area_measurement_view.dart';

class SearchView extends HookConsumerWidget {
  final ValueNotifier<CameraController?> cameraController;
  const SearchView({
    required this.cameraController,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCamera = useState(true);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 8,
          automaticallyImplyLeading: false,
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
            isCamera.value
                ? PictureSearchView(
                    cameraController: cameraController, isCamera: isCamera)
                : AreaMeasurementView(isCamera: isCamera),
            const KeywordSearchView(),
          ],
        ),
      ),
    );
  }
}
