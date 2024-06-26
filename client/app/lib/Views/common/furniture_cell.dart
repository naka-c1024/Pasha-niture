import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../Domain/constants.dart';
import '../../Domain/furniture.dart';
import '../../Domain/theme_color.dart';
import '../../Usecases/provider.dart';
import 'furniture_detail_view.dart';
import 'sold_painter.dart';

class FurnitureCell extends HookConsumerWidget {
  final Furniture furniture;

  const FurnitureCell({
    required this.furniture,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final userName = ref.read(userNameProvider);

    bool isMyProduct(){
      if(furniture.userName == userName){
        return true;
      } else {
        return false;
      }
    }

    return ElevatedButton(
      onPressed: () {
        // 家具の詳細ページへ
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FurnitureDetailView(
              furniture: furniture,
              isMyProduct: isMyProduct(),
              isHiddenButton: furniture.isSold,
            ),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Container(
        height: (screenSize.width - 40) / 3,
        width: (screenSize.width - 40) / 3,
        margin: const EdgeInsets.only(left: 4, right: 4, bottom: 8),
        decoration: BoxDecoration(
          color: ThemeColors.bgGray1,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Center(
                child: Image.memory(furniture.image!),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                furniture.isSold
                    ? CustomPaint(
                        size: const Size(52, 52),
                        painter: SoldPainter(),
                      )
                    : const SizedBox(),
                Container(
                  height: 24,
                  width: 64,
                  padding: const EdgeInsets.only(left: 8, top: 2),
                  decoration: BoxDecoration(
                    color: const Color(0x66666666),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    prefectures[furniture.area],
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xffffffff),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            furniture.isSold
                ? Column(
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        transform: Matrix4.rotationZ(-45 * pi / 180),
                        transformAlignment: Alignment.center,
                        child: const Text(
                          ' SOLD',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
