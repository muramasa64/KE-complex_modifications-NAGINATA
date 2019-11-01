#!/usr/bin/env ruby
#
# You can generate json for ANSI and Dvorak layout by executing the following command on Terminal.
# $ ruby ./japanese_naginata.json.rb dv > ../../docs/json/japanese_naginata_dvorak.json
#
# Horizontal Version
# $ ruby ./japanese_naginata.json.rb dh > ../../docs/json/japanese_naginata_dvorak_h.json
#
# and put here.
# ~/.config/karabiner/assets/complex_modifications/
#
# This script made based example_japanese_nicola.json.rb.
#
#
#
# This software based on カナ配列「薙刀式」
# http://oookaworks.seesaa.net/article/456099128.html
#
# This Mac porting version hosted on https://github.com/sorshi/KE-complex_modifications-NAGINATA
# made by DCC-JPL Japan<http://www.dcc-jpl.com/>/Sorshi<sorshi@dcc-jpl.com>

require_relative './japanese_naginata.json.rb'

def redef_without_warning(const, value)
  self.class.send(:remove_const, const) if self.class.const_defined?(const)
  self.class.const_set(const, value)
end

# Dvorak配列を指定するオプション
if ARGV[0] == 'dh' then
  # Dvorak配列(横書き)キーアサイン
  redef_without_warning('LEFT_ARROW', 'down_arrow'.freeze)
  redef_without_warning('RIGHT_ARROW', 'up_arrow'.freeze)
  redef_without_warning('UP_ARROW', 'left_arrow'.freeze)
  redef_without_warning('DOWN_ARROW', 'right_arrow'.freeze)
  redef_without_warning('MODE', 'Dvorak (Horizontal)'.freeze)
elsif ARGV[0] == 'dv' then
  # Dvorak配列(縦書き)キーアサイン
  redef_without_warning('LEFT_ARROW', 'left_arrow'.freeze)
  redef_without_warning('RIGHT_ARROW', 'right_arrow'.freeze)
  redef_without_warning('UP_ARROW', 'up_arrow'.freeze)
  redef_without_warning('DOWN_ARROW', 'down_arrow'.freeze)
  redef_without_warning('MODE', 'Dvorak (Vertical)'.freeze)
end

# 特殊キー
THUMB_SHIFT = 'lang9'

def main
  now = Time.now.to_i
  puts JSON.pretty_generate(
    'title' => 'Japanese NAGINATA STYLE (v11)',
    'rules' => [
      {
        'description' => "Japanese NAGINATA STYLE (v11) #{MODE}#{TYKEYMODE}Build #{now} ",
        'manipulators' => [
          # 同時打鍵数の多いものから書く
          shiftkeydef(),#連続シフト用定義
          #編集モード1定義
          editmode_one_left(COLON,'文末'),
          editmode_one_left(COMMA,'文頭'),
          # PERIOD,pは未使用
          editmode_one_left('p','十字目'),
          editmode_one_left('a','リドゥ'),#shift + command + z
          editmode_one_left('o','保存'),
          editmode_one_left('e','頁下'),
          editmode_one_left('u','頁上'),
          editmode_one_left('i','二十字目'),
          editmode_one_left(SEMICOLON,'アンドゥ'),
          editmode_one_left('q','カット'),
          editmode_one_left('j','コピー'),
          editmode_one_left('k','ペースト'),
          editmode_one_left('x','三十字目'),
          editmode_one_right('f','行頭'),
          editmode_one_right('g','行末削除'),
          editmode_one_right('c','再変換'),
          editmode_one_right('r','削除'),
          editmode_one_right('l','入力撤回'),
          editmode_one_right('d','確定エンド'),
          editmode_one_right('h','上矢印'),
          editmode_one_right('t','シフト上矢印'),
          editmode_one_right('n','五上矢印'),
          editmode_one_right('s','カタカナに'),
          editmode_one_right('b','行末'),
          editmode_one_right('m','下矢印'),
          editmode_one_right('w','シフト下矢印'),
          editmode_one_right('v','五下矢印'),
          editmode_one_right('z','ひらがなに'),
          #編集モード2定義
          editmode_two_left(COLON,'／改'),
          editmode_two_left(COMMA,'：改'),
          editmode_two_left(PERIOD,'・改'),
          #editmode_two_left('p','○改'),
          three_keys('m','w','p','○改'),
          editmode_two_left('p','行頭空白改'),
          editmode_two_left('a','【改'),
          editmode_two_left('o','〈改'),
          editmode_two_left('e','！改'),
          editmode_two_left('u','？改'),
          editmode_two_left('i','行頭空白三改'),
          editmode_two_left(';','】改'),
          editmode_two_left('q','〉改'),
          editmode_two_left('j','……改'),
          editmode_two_left('k','──改'),
          editmode_two_left('x','三空白'),
          editmode_two_right('f','」改改空'),
          editmode_two_right('c','行頭削除'),
          editmode_two_right('r','確定復行'),#確定Undo
          editmode_two_right('r','縦棒改'),
          # editmode_two_right('l','ルビ'),
          three_keys('v','c','p','ルビ'),
          editmode_two_right('d','」改「'),
          editmode_two_right('h','「改'),
          editmode_two_right('t','『改'),
          # editmode_two_right('n','《改'),
          three_keys('k','j','n','《改'),
          editmode_two_right('s','（改'),
          editmode_two_right('b','」改改'),
          editmode_two_right('m','」改'),
          editmode_two_right('w','』改'),
          # editmode_two_right('v','》改'),
          three_keys('k','j','v','》改'),
          editmode_two_right('z','）改'),
          # 3同時打鍵
          # 小書き： シフト半濁音同時押し
          three_keys(THUMB_SHIFT,'v','j','ぁ'),
          three_keys(THUMB_SHIFT,'k','t','ぃ'),
          three_keys(THUMB_SHIFT,'k','n','ぅ'),
          three_keys(THUMB_SHIFT,'k','l','ぇ'),
          three_keys(THUMB_SHIFT,'m','y','ぇ'),#Mac版のみの拡張
          three_keys(THUMB_SHIFT,'k','b','ぉ'),
          three_keys(THUMB_SHIFT,'k','s','ゃ'),
          three_keys(THUMB_SHIFT,'k','r','ゅ'),
          three_keys(THUMB_SHIFT,'k','c','ょ'),
          three_keys(THUMB_SHIFT,'k','d','ゎ'),
          # シフト「りゅ」のみ「てゅ」に定義
          three_keys(THUMB_SHIFT, PERIOD,'r','てゅ'),
          three_keys('o','h','s','ぎゃ'),
          three_keys('p','h','s','じゃ'),
          three_keys('i','h','s','ぢゃ'),
          three_keys('q','h','s','びゃ'),
          three_keys('o','h','o','ぎゅ'),
          three_keys('p','h','o','じゅ'),
          three_keys('i','h','o','ぢゅ'),
          three_keys('q','h','o','びゅ'),
          three_keys('o','h','c','ぎょ'),
          three_keys('p','h','c','じょ'),
          three_keys('i','h','c','ぢょ'),
          three_keys('q','h','c','びょ'),
          # じゅぎゅが打ちにくいので、例外的に半濁音キーでもオーケーとする
          three_keys('p','m','c','じょ'),
          three_keys('p','m','s','じゃ'),
          three_keys('p','m','r','じゅ'),
          three_keys('o','m','c','ぎょ'),
          three_keys('o','m','s','ぎゃ'),
          three_keys('o','m','r','ぎゅ'),
          three_keys('i','m','c','ぢょ'),
          three_keys('i','m','s','ぢゃ'),
          three_keys('i','m','r','ぢゅ'),
          three_keys('x','j','c','びょ'),
          three_keys('x','j','r','びゅ'),
          # 半濁音ゃゅょは「ぴ」のみ
          three_keys('q','m','c','ぴょ'),
          three_keys('q','m','s','ぴゃ'),
          three_keys('q','m','r','ぴゅ'),
          three_keys('e','j','r','でゅ'),
          three_keys('p','j','l','じぇ'),
          three_keys('i','j','l','ぢぇ'),
          three_keys(PERIOD,'j','t','でぃ'),
          three_keys('e','j','n','どぅ'),
          #ツァ行は「う」「つ」が同じキーにあるためシフトを押しながら
          three_keys(THUMB_SHIFT, 'n','h','つぁ'),
          three_keys(THUMB_SHIFT, 'n','t','つぃ'),
          three_keys(THUMB_SHIFT, 'n','l','つぇ'),
          three_keys(THUMB_SHIFT, 'n','b','つぉ'),
          #Mac版のみの拡張
          three_keys('p','h','y','じぇ'),
          three_keys('i','h','y','ぢぇ'),
          # ------------------------------
          # 2同時打鍵
          # 右手濁点
          two_keys('g','u','ざ'),
          two_keys('r','u','ず'),
          two_keys('l','u','べ'),
          two_keys('d','u','ぐ'),
          two_keys('n','u','づ'),
          two_keys('b','u','だ'),
          two_keys('v','u','ぶ'),
          # 左手濁点
          two_keys('o','h','ぎ'),
          two_keys(PERIOD,'h','で'),
          two_keys('p','h','じ'),
          two_keys(SEMICOLON,'h','ぼ'),
          two_keys('j','h','げ'),
          two_keys('e','h','ど'),
          two_keys('u','h','が'),
          two_keys('i','h','ぢ'),
          two_keys('a','h','ぜ'),
          two_keys('q','h','び'),
          two_keys(COMMA,'h','ば'),
          two_keys('k','h','ご'),
          two_keys('x','h','ぞ'),
          # 右手半濁音
          two_keys('l','k','ぺ'),
          two_keys('z','k','ぷ'),
          # 左手半濁音
          two_keys(SEMICOLON,'m','ぽ'),
          two_keys('q','m','ぴ'),
          two_keys(COMMA,'m','ぱ'),
          # 拗音シフト やゆよと同時押しで、ゃゅょが付く
          two_keys('o','s', 'きゃ'),
          two_keys(PERIOD,'s', 'りゃ'),
          two_keys('p','s', 'しゃ'),
          two_keys(COMMA,'s', 'みゃ'),
          two_keys('e','s', 'にゃ'),
          two_keys('i','s', 'ちゃ'),
          two_keys('q','s', 'ひゃ'),
          two_keys('o','r','きゅ'),
          two_keys(PERIOD,'r','りゅ'),
          two_keys('p','r','しゅ'),
          two_keys(COMMA,'r','みゅ'),
          two_keys('e','r','にゅ'),
          two_keys('i','r','ちゅ'),
          two_keys('q','r','ひゅ'),
          two_keys('o','c','きょ'),
          two_keys(PERIOD,'c','りょ'),
          two_keys('p','c','しょ'),
          two_keys('e','c','にょ'),
          two_keys('i','c','ちょ'),
          two_keys('q','c','ひょ'),
          two_keys(COMMA,'c','みょ'),
          two_keys(COMMA,'s','みゃ'),
          two_keys(COMMA,'r','みゅ'),
          two_keys('p','c','しょ'),
          two_keys('p','s','しゃ'),
          two_keys('p','r','しゅ'),
          two_keys('o','c','きょ'),
          two_keys('o','s','きゃ'),
          two_keys('o','r','きゅ'),
          two_keys('e','c','にょ'),
          two_keys('e','s','にゃ'),
          two_keys('e','r','にゅ'),
          two_keys('i','c','ちょ'),
          two_keys('i','s','ちゃ'),
          two_keys('i','r','ちゅ'),
          two_keys('q','c','ひょ'),
          two_keys('q','s','ひゃ'),
          two_keys('q','r','ひゅ'),
          # 外来音
          two_keys(PERIOD,'t','てぃ'),
          two_keys('e','n','とぅ'),
          two_keys(COLON,'l','ヴぇ'),
          two_keys(COLON,'h','ヴぁ'),
          two_keys(COLON,'t','ヴぃ'),
          two_keys(COLON,'b','ヴぉ'),
          two_keys(COLON,'r','ヴゅ'),
          # 右手領域の同時押し外来音
          two_keys('n','h','うぁ'),
          two_keys('n','t','うぃ'),
          two_keys('n','l','うぇ'),
          two_keys('n','b','うぉ'),
          two_keys('v','h','ふぁ'),
          two_keys('v','t','ふぃ'),
          two_keys('v','l','ふぇ'),
          two_keys('v','b','ふぉ'),
          two_keys('v','r','ふゅ'),
          two_keys('p','l','しぇ'),
          two_keys('i','l','ちぇ'),
          #特殊操作
          two_keys('k','m','改'),
          two_keys_always('d','g','仮'),#USモードでも効く定義
          two_keys('u','i','英'),
          #Mac版のみの拡張
          two_keys('f','u','べ'),
          two_keys('f','k','ぺ'),
          two_keys(COLON,'f','ヴぇ'),
          two_keys('n','y','うぇ'),
          two_keys('v','y','ふぇ'),
          two_keys('p','y','しぇ'),
          two_keys('i','y','ちぇ'),
          # ------------------------------
          # シフト(スペースキー)
          #shift_key(COLON, ''),
          shift_key('o', 'ね'),
          shift_key('e', 'り'),
          shift_key('w', 'む'),
          shift_key('g', 'さ'),
          shift_key('c', 'よ'),
          shift_key('l', 'え'),
          shift_key('p', 'め'),
          shift_key(COMMA, 'み'),
          shift_key('e', 'に'),
          shift_key('u', 'ま'),
          shift_key('i', 'ち'),
          shift_key('d', 'わ'),
          shift_key('h', 'の'),
          shift_key('t', 'も'),
          shift_key('n', 'つ'),
          shift_key('s', 'や'),
          shift_key('a', 'せ'),
          #shift_key(SEMICOLON, ''),
          #shift_key('q', ''),
          shift_key('j', 'を'),
          shift_key('k', '、'),
          shift_key('x', 'ぬ'),
          shift_key('b', 'お'),
          shift_key('m', '。改'),
          shift_key('r', 'ゆ'),
          shift_key('v', 'ふ'),
          shift_key('y', TKEY),
          shift_key('f', YKEY),
          #shift_key('z', ''),
          # ------------------------------
          # 連続シフトシフト(スペースキー)
          #continuous_shift(COLON, ''),
          continuous_shift('o', 'ね'),
          continuous_shift(PERIOD, 'り'),
          continuous_shift('w', 'む'),
          continuous_shift('g', 'さ'),
          continuous_shift('c', 'よ'),
          continuous_shift('l', 'え'),
          continuous_shift('p', 'め'),
          continuous_shift(COMMA, 'み'),
          continuous_shift('e', 'に'),
          continuous_shift('u', 'ま'),
          continuous_shift('i', 'ち'),
          continuous_shift('d', 'わ'),
          continuous_shift('h', 'の'),
          continuous_shift('t', 'も'),
          continuous_shift('n', 'つ'),
          continuous_shift('s', 'や'),
          continuous_shift('a', 'せ'),
          #continuous_shift(SEMICOLON, ''),
          #continuous_shift('q', ''),
          continuous_shift('j', 'を'),
          continuous_shift('k', '、'),
          continuous_shift('x', 'ぬ'),
          continuous_shift('b', 'お'),
          continuous_shift('m', '。改'),
          continuous_shift('r', 'ゆ'),
          continuous_shift('v', 'ふ'),
          continuous_shift('y', TKEY),
          continuous_shift('f', YKEY),
          #continuous_shift('z', ''),
          # ------------------------------
          # シフトなし(単打)
          normal_key(COLON, 'ヴ'),
          normal_key('o', 'き'),
          normal_key(PERIOD, 'て'),
          normal_key('p', 'し'),
          normal_key('y', '←'),
          normal_key('f', '→'),
          normal_key('g', '削'),
          normal_key('c', 'る'),
          normal_key('r', 'す'),
          normal_key('l', 'へ'),
          normal_key(SEMICOLON, 'ほ'),
          normal_key('j', 'け'),
          normal_key('e', 'と'),
          normal_key('u', 'か'),
          normal_key('i', 'っ'),
          normal_key('d', 'く'),
          normal_key('h', 'あ'),
          normal_key('t', 'い'),
          normal_key('n', 'う'),
          normal_key('s', 'ー'),
          normal_key('a', 'ろ'),
          normal_key('q', 'ひ'),
          normal_key(COMMA, 'は'),
          normal_key('k', 'こ'),
          normal_key('x', 'そ'),
          normal_key('b', 'た'),
          normal_key('m', 'な'),
          normal_key('w', 'ん'),
          normal_key('v', 'ら'),
          normal_key('z', 'れ'),
          #PC用キーボード定義
          normal_key_always('international4','仮'),#PC用JISキーボードつないだときの定義 (変換)& USモードでも効く定義
          normal_key('international5','英'),#PC用JISキーボードつないだときの定義 (無変換)
        ],
      },
    ]
  )
end


def shiftkeydef()
  {
    'type' => 'basic',
    'from' => {
      'key_code' => THUMB_SHIFT,
    },
    'to' => [
      'set_variable'=>
        {'name' => 'shifted','value' => 1}
    ],
    'to_if_alone' => [
      'key_code' => THUMB_SHIFT
    ],
    'to_after_key_up' => [
      'set_variable'=>
        {'name' => 'shifted','value' => 0}
    ],
    'parameters': { 'basic.to_if_held_down_threshold_milliseconds': 800 },
    'to_if_held_down': [
      {
        'key_code': THUMB_SHIFT,
        'repeat': true
      }
    ],
    'conditions' => CONDITIONS,
  }
end

def normal_key(key, char)
  {
    'type' => 'basic',
    'from' => {
      'key_code' => key,
    },
    'to' => ROMAN_MAP[char],
    'conditions' => CONDITIONS,
  }
end

def normal_key_always(key, char)
  {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => key,
        }
      ],
    },
    'to' => ROMAN_MAP[char],
  }
end

def continuous_shift(key, char)
  {
    'type' => 'basic',
    'from' => {
      'key_code' => key,
    },
    'to' => ROMAN_MAP[char],
    'conditions' => CONDITIONS_SHIFT,
  }
end

def shift_key(key, char)
  {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => key,
        },
        {
          'key_code' => THUMB_SHIFT,
        },
      ],
    },
    'to' => ROMAN_MAP[char],
    #'set_variable': { 'name': 'shifted','value': 1 },
    'conditions' => CONDITIONS,
    'to_after_key_up': [
      {
        'set_variable': {
          'name': 'shifted',
          'value': 0
        }
      }
    ]
  }
end

def two_keys(key,key2, char)
  {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => key,
        },
        {
          'key_code' => key2,
        },
      ],
    },
    'to' => ROMAN_MAP[char],
    'conditions' => CONDITIONS,
  }
end

def two_keys_always(key,key2, char)
  {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => key,
        },
        {
          'key_code' => key2,
        },
      ],
    },
    'to' => ROMAN_MAP[char],
  }
end

def three_keys(key,key2,key3, char)
  {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => key,
        },
        {
          'key_code' => key2,
        },
        {
          'key_code' => key3,
        },
      ],
    },
    'to' => ROMAN_MAP[char],
    'conditions' => CONDITIONS,
  }
end

def four_keys(key,key2,key3,key4, char)
  {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => key,
        },
        {
          'key_code' => key2,
        },
        {
          'key_code' => key3,
        },
        {
          'key_code' => key4,
        },
      ],
    },
    'to' => ROMAN_MAP[char],
    'conditions' => CONDITIONS,
  }
end

def editmode_two_left(key,char)
  {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => 'm',
        },
        {
          'key_code' => COMMA,
        },
        {
          'key_code' => key,
        },
      ],
    },
    'to' => ROMAN_MAP[char],
    'conditions' => CONDITIONS,
  }
end

def editmode_two_right(key,char)
  {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => 'v',
        },
        {
          'key_code' => 'c',
        },
        {
          'key_code' => key,
        },
      ],
    },
    'to' => ROMAN_MAP[char],
    'conditions' => CONDITIONS,
  }
end

def editmode_one_left(key,char)
  {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => 'j',
        },
        {
          'key_code' => 'k',
        },
        {
          'key_code' => key,
        },
      ],
    },
    'to' => ROMAN_MAP[char],
    'conditions' => CONDITIONS,
  }
end

def editmode_one_right(key,char)
  {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => 'd',
        },
        {
          'key_code' => 'f',
        },
        {
          'key_code' => key,
        },
      ],
    },
    'to' => ROMAN_MAP[char],
    'conditions' => CONDITIONS,
  }
end

if __FILE__ == $PROGRAM_NAME
  main
end
