import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../Domain/trade.dart';
import '../../Domain/theme_color.dart';
import '../../../Usecases/provider.dart';
import '../../../Usecases/furniture_api.dart';
import 'error_dialog.dart';
import 'trade_detail_view.dart';

class TodoCell extends HookConsumerWidget {
  final Trade trade;
  final int tradeStatus;
  const TodoCell({
    required this.trade,
    required this.tradeStatus,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.read(userIdProvider);

    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              // 取引承認ページへ
              final futureResult =
                  getFurnitureDetails(userId, trade.furnitureId);
              futureResult.then((result) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TradeDetailView(
                      trade: trade,
                      furniture: result,
                      tradeStatus: tradeStatus,
                    ),
                  ),
                );
              }).catchError((error) {
                showErrorDialog(context, error.toString());
              });
            },
            child: Ink(
              height: 88,
              color: const Color(0xffffffff),
              child: Row(
                children: [
                  Container(
                    height: 88,
                    width: 88,
                    decoration: BoxDecoration(
                      color: ThemeColors.bgGray1,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Center(
                        child: Image.memory(trade.image),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        tradeStatus == 0
                            ? '取引依頼の返事を待っています。'
                            : tradeStatus == 1
                                ? '取引依頼が届きました。'
                                : tradeStatus == 2
                                    ? '取引は完了しましたか？'
                                    : '相手の完了待ちです。',
                        style: const TextStyle(
                          fontSize: 14,
                          color: ThemeColors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        tradeStatus == 0
                            ? '返答を待ちましょう。'
                            : tradeStatus == 1
                                ? '取引を受けるか、返答しましょう。'
                                : tradeStatus == 2
                                    ? '取引を完了しましょう。'
                                    : '相手が完了するのを待ちましょう.',
                        style: const TextStyle(
                          fontSize: 12,
                          color: ThemeColors.textGray1,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 24,
                    color: ThemeColors.lineGray2,
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          ),
        ),
        const Divider(color:ThemeColors.lineGray1),
      ],
    );
  }
}
