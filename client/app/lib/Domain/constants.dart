// 定数をまとめたファイル
// インデックスは全て0スタート

import 'dart:ui';

const ipAddress = '192.168.2.142';

// 都道府県コード
final prefectures = [
  '北海道',
  '青森県',
  '岩手県',
  '宮城県',
  '秋田県',
  '山形県',
  '福島県',
  '茨城県',
  '栃木県',
  '群馬県',
  '埼玉県',
  '千葉県',
  '東京都',
  '神奈川県',
  '新潟県',
  '富山県',
  '石川県',
  '福井県',
  '山梨県',
  '長野県',
  '岐阜県',
  '静岡県',
  '愛知県',
  '三重県',
  '滋賀県',
  '京都府',
  '大阪府',
  '兵庫県',
  '奈良県',
  '和歌山県',
  '鳥取県',
  '島根県',
  '岡山県',
  '広島県',
  '山口県',
  '徳島県',
  '香川県',
  '愛媛県',
  '高知県',
  '福岡県',
  '佐賀県',
  '長崎県',
  '熊本県',
  '大分県',
  '宮崎県',
  '鹿児島県',
  '沖縄県'
];

// カテゴリコード
final categorys = [
  'ソファ',
  'チェア・椅子',
  'テーブル',
  'デスク・机',
  '寝具・寝具用品',
  '収納家具',
  '照明器具',
  'カーテン',
  'ラグ・カーペット',
  'テレビ台',
  'インテリア家具',
  'その他'
];

// カラーコード
final colors = [
  'ホワイト系',
  'ブラック系',
  'グレー系',
  'パープル系',
  'ブラウン系',
  'ベージュ系',
  'レッド系',
  'ピンク系',
  'オレンジ系',
  'イエロー系',
  'グリーン系',
  'ブルー系',
];

final colorCodes = [
  const Color(0xffffffff),
  const Color(0xff000000),
  const Color(0xff898989),
  const Color(0xffbb4efe),
  const Color(0xffa57166),
  const Color(0xfff4d9ba),
  const Color(0xfffe4e52),
  const Color(0xffffadaf),
  const Color(0xfffe984e),
  const Color(0xfffee24e),
  const Color(0xff72e176),
  const Color(0xff5f8ee9),
];

// 商品の状態
final conditions = [
  '新品、未使用',
  '未使用に近い',
  '目立った傷や汚れなし',
  'やや傷や汚れあり',
  '傷や汚れあり',
  '全体的に状態が悪い',
];
