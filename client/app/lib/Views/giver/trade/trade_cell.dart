import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../Domain/trade.dart';
import '../../../Domain/theme_color.dart';
import '../../../Usecases/provider.dart';
import '../../../Usecases/furniture_api.dart';
import '../../common/error_dialog.dart';
import '../../common/trade_detail_view.dart';

class TradeCell extends HookConsumerWidget {
  final Trade trade;
  final bool isTrading;
  const TradeCell({
    required this.trade,
    required this.isTrading,
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
                      tradeStatus: isTrading ? 2 : 1,
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
                        trade.productName,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xff000000),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isTrading
                            ? '受け渡しは完了しましたか？'
                            : trade.giverApproval
                                ? '取引相手の完了待ちです。'
                                : '取引依頼を承認しますか？',
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
                    color: Color(0xff575757),
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
