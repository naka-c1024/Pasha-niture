import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../Domain/constants.dart';
import '../../Domain/theme_color.dart';

class AreaFilterMenu extends HookConsumerWidget {
  final ValueNotifier<List<int>> selectedArea;
  const AreaFilterMenu({
    required this.selectedArea,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelectingArea0 = useState(false);
    final isSelectingArea1 = useState(false);
    final isSelectingArea2 = useState(false);
    final isSelectingArea3 = useState(false);
    final isSelectingArea4 = useState(false);
    final isSelectingArea5 = useState(false);

    const area0 = [0, 1, 2, 3, 4, 5, 6];
    const area1 = [7, 8, 9, 10, 11, 12, 13];
    const area2 = [14, 15, 16, 17, 18, 19, 20, 21, 22];
    const area3 = [23, 24, 25, 26, 27, 28, 29];
    const area4 = [30, 31, 32, 33, 34, 35, 36, 37, 38];
    const area5 = [39, 40, 41, 42, 43, 44, 45, 46, 47];

    useEffect(() {
      if (area0.any((items) => selectedArea.value.contains(items))) {
        isSelectingArea0.value = true;
      }
      if (area1.any((items) => selectedArea.value.contains(items))) {
        isSelectingArea1.value = true;
      }
      if (area2.any((items) => selectedArea.value.contains(items))) {
        isSelectingArea2.value = true;
      }
      if (area3.any((items) => selectedArea.value.contains(items))) {
        isSelectingArea3.value = true;
      }
      if (area4.any((items) => selectedArea.value.contains(items))) {
        isSelectingArea4.value = true;
      }
      if (area5.any((items) => selectedArea.value.contains(items))) {
        isSelectingArea5.value = true;
      }
      return null;
    }, []);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '受け渡しエリア',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: ThemeColors.black,
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              isSelectingArea0.value = !isSelectingArea0.value;
            },
            child: Container(
              height: 32,
              color: const Color(0xffffffff),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '北海道・東北',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: ThemeColors.textGray1,
                    ),
                  ),
                  Icon(
                    isSelectingArea0.value
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: const Color(0xff575757),
                  ),
                ],
              ),
            ),
          ),
          isSelectingArea0.value
              ? Wrap(
                  children: [
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 0),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 1),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 2),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 3),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 4),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 5),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 6),
                  ],
                )
              : const SizedBox(),
          const Divider(color:Color(0xffababab)),
          GestureDetector(
            onTap: () {
              isSelectingArea1.value = !isSelectingArea1.value;
            },
            child: Container(
              height: 32,
              color: const Color(0xffffffff),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '関東',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: ThemeColors.textGray1,
                    ),
                  ),
                  Icon(
                    isSelectingArea1.value
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: const Color(0xff575757),
                  ),
                ],
              ),
            ),
          ),
          isSelectingArea1.value
              ? Wrap(
                  children: [
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 7),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 8),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 9),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 10),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 11),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 12),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 13),
                  ],
                )
              : const SizedBox(),
          const Divider(color:Color(0xffababab)),
          GestureDetector(
            onTap: () {
              isSelectingArea2.value = !isSelectingArea2.value;
            },
            child: Container(
              height: 32,
              color: const Color(0xffffffff),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '中部',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: ThemeColors.textGray1,
                    ),
                  ),
                  Icon(
                    isSelectingArea2.value
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: const Color(0xff575757),
                  ),
                ],
              ),
            ),
          ),
          isSelectingArea2.value
              ? Wrap(
                  children: [
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 14),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 15),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 16),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 17),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 18),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 19),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 20),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 21),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 22),
                  ],
                )
              : const SizedBox(),
          const Divider(color:Color(0xffababab)),
          GestureDetector(
            onTap: () {
              isSelectingArea3.value = !isSelectingArea3.value;
            },
            child: Container(
              height: 32,
              color: const Color(0xffffffff),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '近畿',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: ThemeColors.textGray1,
                    ),
                  ),
                  Icon(
                    isSelectingArea3.value
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: const Color(0xff575757),
                  ),
                ],
              ),
            ),
          ),
          isSelectingArea3.value
              ? Wrap(
                  children: [
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 23),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 24),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 25),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 26),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 27),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 28),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 29),
                  ],
                )
              : const SizedBox(),
          const Divider(color:Color(0xffababab)),
          GestureDetector(
            onTap: () {
              isSelectingArea4.value = !isSelectingArea4.value;
            },
            child: Container(
              height: 32,
              color: const Color(0xffffffff),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '中国・四国',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: ThemeColors.textGray1,
                    ),
                  ),
                  Icon(
                    isSelectingArea4.value
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: const Color(0xff575757),
                  ),
                ],
              ),
            ),
          ),
          isSelectingArea4.value
              ? Wrap(
                  children: [
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 30),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 31),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 32),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 33),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 34),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 35),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 36),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 37),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 38),
                  ],
                )
              : const SizedBox(),
          const Divider(color:Color(0xffababab)),
          GestureDetector(
            onTap: () {
              isSelectingArea5.value = !isSelectingArea5.value;
            },
            child: Container(
              height: 32,
              color: const Color(0xffffffff),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '九州・沖縄',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: ThemeColors.textGray1,
                    ),
                  ),
                  Icon(
                    isSelectingArea5.value
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: const Color(0xff575757),
                  ),
                ],
              ),
            ),
          ),
          isSelectingArea5.value
              ? Wrap(
                  children: [
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 39),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 40),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 41),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 42),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 43),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 44),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 45),
                    AreaCell(selectedArea: selectedArea, prefectureIndex: 46),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class AreaCell extends HookConsumerWidget {
  final ValueNotifier<List<int>> selectedArea;
  final int prefectureIndex;
  const AreaCell({
    required this.selectedArea,
    required this.prefectureIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = useState(false);

    useEffect(() {
      if (selectedArea.value.contains(prefectureIndex)) {
        isSelected.value = true;
      }
      return null;
    }, []);

    return GestureDetector(
      onTap: () {
        if (selectedArea.value.contains(prefectureIndex)) {
          selectedArea.value.remove(prefectureIndex);
          isSelected.value = false;
        } else {
          selectedArea.value.add(prefectureIndex);
          isSelected.value = true;
        }
      },
      child: Container(
        height: 40,
        width: prefectures[prefectureIndex].length * 20 +
            (isSelected.value ? 24 : 0)+2,
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                isSelected.value ? ThemeColors.keyGreen : ThemeColors.bgGray1,
            width: isSelected.value ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isSelected.value
                ? const Icon(
                    Icons.done,
                    size: 20,
                    color: Color(0xff4b4b4b),
                  )
                : const SizedBox(),
            isSelected.value ? const SizedBox(width: 4) : const SizedBox(),
            Text(
              prefectures[prefectureIndex],
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xff4b4b4b),
              ),
            ),
            isSelected.value ? const SizedBox(width: 4) : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
