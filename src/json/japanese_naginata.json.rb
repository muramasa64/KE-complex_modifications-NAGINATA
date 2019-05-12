#!/usr/bin/env ruby

# You can generate json by executing the following command on Terminal.
#
# $ ruby ./japanese_naginata.json.rb > ../../docs/json/japanese_naginata.json
#
# This script made based example_japanese_nicola.json.rb.

require 'json'
require 'date'

require_relative '../lib/karabiner.rb'

########################################
# キーコード(親指シフトと違ってそのまんまだから意味ないな…)

SPACEBAR = 'spacebar'.freeze
LEFT_ARROW = 'left_arrow'.freeze
RIGHT_ARROW = 'right_arrow'.freeze
BACK_SPACE = 'delete_or_backspace'.freeze
ENTER = 'return_or_enter'.freeze
HYPHEN = 'hyphen'.freeze
COMMA = 'comma'.freeze
PERIOD = 'period'.freeze
SEMICOLON = 'semicolon'.freeze
SLASH = 'slash'.freeze
QUOTE = 'quote'.freeze
JPN = 'lang1'.freeze
ENG = 'lang2'.freeze

########################################
# QWERTY配列
#
# lu = 左上段（left up）
# lm = 左中段（left middle）
# ld = 左下段（left down）
# ru = 右上段（right up）
# rm = 右中段（right middle）
# rd = 右下段（right down）
#
# 0 = 人差し指（伸ばし）
# 1 = 人差し指
# 2 = 中指
# 3 = 薬指
# 4 = 小指
#
# sp = スペース
class Qwerty
  def initialize
    @name = "Qwerty"
    @lu = ['q', 'w', 'e', 'r', 't'].reverse
    @lm = ['a', 's', 'd', 'f', 'g'].reverse
    @ld = ['z', 'x', 'c', 'v', 'b'].reverse

    @ru = ['y', 'u', 'i', 'o', 'p']
    @rm = ['h', 'j', 'k', 'l', SEMICOLON]
    @rd = ['n', 'm', COMMA, PERIOD, SLASH]

    @lsp = SPACEBAR
    @rsp = SPACEBAR
    @sp  = @rsp
  end
  attr_reader :lu, :lm, :ld, :ru, :rm, :rd, :lsp, :rsp, :sp, :name
end

########################################
# Dvorak配列
class Dvorak
  def initialize
    @name = "Dvorak"
    @lu = [QUOTE, COMMA, PERIOD, 'p', 'y'].reverse
    @lm = ['a', 'o', 'e', 'u', 'i'].reverse
    @ld = [SEMICOLON, 'q', 'j', 'k', 'x'].reverse

    @ru = ['f', 'g', 'c', 'r', 'l']
    @rm = ['d', 'h', 't', 'n', 's']
    @rd = ['b', 'm', 'w', 'v', 'z']

    @lsp = SPACEBAR
    @rsp = SPACEBAR
    @sp  = @rsp
  end
  attr_reader :lu, :lm, :ld, :ru, :rm, :rd, :lsp, :rsp, :sp, :name
end

########################################
# 有効になる条件

CONDITIONS = [
  Karabiner.input_source_if([
    {
      'input_mode_id' => 'com.apple.inputmethod.Japanese',
    },
    {
      'input_mode_id' => 'com.apple.inputmethod.Japanese.Hiragana',
    },
    {
      'input_mode_id' => 'com.apple.inputmethod.Japanese.Katakana',
    },
    {
      'input_mode_id' => 'com.apple.inputmethod.Japanese.HalfWidthKana',
    },
  ]),
  Karabiner.frontmost_application_unless(['loginwindow']),
].freeze

# 連続シフト用
CONDITIONS_SHIFT = [
  Karabiner.input_source_if([
    {
      'input_mode_id' => 'com.apple.inputmethod.Japanese',
    },
    {
      'input_mode_id' => 'com.apple.inputmethod.Japanese.Hiragana',
    },
    {
      'input_mode_id' => 'com.apple.inputmethod.Japanese.Katakana',
    },
    {
      'input_mode_id' => 'com.apple.inputmethod.Japanese.HalfWidthKana',
    },
  ]),
  Karabiner.frontmost_application_unless(['loginwindow']),
  {
    'type' =>'variable_if',
    'name' => 'shifted',
    'value' =>  1
  }
].freeze

########################################
# ローマ字入力の定義

def key(key_code)
  {
    'key_code' => key_code,
    'repeat' => false,
  }
end

def key_with_repeat(key_code)
  {
    'key_code' => key_code,
    'repeat' => true,
  }
end

def key_with_shift(key_code)
  {
    'key_code' => key_code,
    'modifiers' => [
      'left_shift',
    ],
    'repeat' => false,
  }
end

ROMAN_MAP = {
  'あ' => [key('a')],
  'い' => [key('i')],
  'う' => [key('u')],
  'え' => [key('e')],
  'お' => [key('o')],
  'か' => [key('k'), key('a')],
  'き' => [key('k'), key('i')],
  'く' => [key('k'), key('u')],
  'け' => [key('k'), key('e')],
  'こ' => [key('k'), key('o')],
  'さ' => [key('s'), key('a')],
  'し' => [key('s'), key('i')],
  'す' => [key('s'), key('u')],
  'せ' => [key('s'), key('e')],
  'そ' => [key('s'), key('o')],
  'た' => [key('t'), key('a')],
  'ち' => [key('t'), key('i')],
  'つ' => [key('t'), key('u')],
  'て' => [key('t'), key('e')],
  'と' => [key('t'), key('o')],
  'な' => [key('n'), key('a')],
  'に' => [key('n'), key('i')],
  'ぬ' => [key('n'), key('u')],
  'ね' => [key('n'), key('e')],
  'の' => [key('n'), key('o')],
  'は' => [key('h'), key('a')],
  'ひ' => [key('h'), key('i')],
  'ふ' => [key('h'), key('u')],
  'へ' => [key('h'), key('e')],
  'ほ' => [key('h'), key('o')],
  'ま' => [key('m'), key('a')],
  'み' => [key('m'), key('i')],
  'む' => [key('m'), key('u')],
  'め' => [key('m'), key('e')],
  'も' => [key('m'), key('o')],
  'や' => [key('y'), key('a')],
  'ゆ' => [key('y'), key('u')],
  'よ' => [key('y'), key('o')],
  'ら' => [key('r'), key('a')],
  'り' => [key('r'), key('i')],
  'る' => [key('r'), key('u')],
  'れ' => [key('r'), key('e')],
  'ろ' => [key('r'), key('o')],
  'わ' => [key('w'), key('a')],
  'を' => [key('w'), key('o')],
  'ん' => [key('n'), key('n')],
  'ゃ' => [key('x'), key('y'), key('a')],
  'ゅ' => [key('x'), key('y'), key('u')],
  'ょ' => [key('x'), key('y'), key('o')],
  'ぁ' => [key('x'), key('a')],
  'ぃ' => [key('x'), key('i')],
  'ぅ' => [key('x'), key('u')],
  'ぇ' => [key('x'), key('e')],
  'ぉ' => [key('x'), key('o')],
  'っ' => [key('x'), key('t'), key('u')],
  'ゎ' => [key('x'), key('w'), key('a')],
  'が' => [key('g'), key('a')],
  'ぎ' => [key('g'), key('i')],
  'ぐ' => [key('g'), key('u')],
  'げ' => [key('g'), key('e')],
  'ご' => [key('g'), key('o')],
  'ざ' => [key('z'), key('a')],
  'じ' => [key('z'), key('i')],
  'ず' => [key('z'), key('u')],
  'ぜ' => [key('z'), key('e')],
  'ぞ' => [key('z'), key('o')],
  'だ' => [key('d'), key('a')],
  'ぢ' => [key('d'), key('i')],
  'づ' => [key('d'), key('u')],
  'で' => [key('d'), key('e')],
  'ど' => [key('d'), key('o')],
  'ば' => [key('b'), key('a')],
  'び' => [key('b'), key('i')],
  'ぶ' => [key('b'), key('u')],
  'べ' => [key('b'), key('e')],
  'ぼ' => [key('b'), key('o')],
  'ぱ' => [key('p'),key('a')],
  'ぴ' => [key('p'),key('i')],
  'ぷ' => [key('p'),key('u')],
  'ぺ' => [key('p'),key('e')],
  'ぽ' => [key('p'),key('o')],
  'ヴ' => [key('v'), key('u')],
  'きゃ' => [key('k'), key('y'), key('a')],
  'きゅ' => [key('k'), key('y'), key('u')],
  'きょ' => [key('k'), key('y'), key('o')],
  'しゃ' => [key('s'), key('y'), key('a')],
  'しゅ' => [key('s'), key('y'), key('u')],
  'しょ' => [key('s'), key('y'), key('o')],
  'ちゃ' => [key('t'), key('y'), key('a')],
  'ちゅ' => [key('t'), key('y'), key('u')],
  'ちょ' => [key('t'), key('y'), key('o')],
  'にゃ' => [key('n'), key('y'), key('a')],
  'にゅ' => [key('n'), key('y'), key('u')],
  'にょ' => [key('n'), key('y'), key('o')],
  'ひゃ' => [key('h'), key('y'), key('a')],
  'ひゅ' => [key('h'), key('y'), key('u')],
  'ひょ' => [key('h'), key('y'), key('o')],
  'ぴゃ' => [key('p'), key('y'), key('a')],
  'ぴゅ' => [key('p'), key('y'), key('u')],
  'ぴょ' => [key('p'), key('y'), key('o')],
  'みゃ' => [key('m'), key('y'), key('a')],
  'みゅ' => [key('m'), key('y'), key('u')],
  'みょ' => [key('m'), key('y'), key('o')],
  'ぎゃ' => [key('g'), key('y'), key('a')],
  'ぎゅ' => [key('g'), key('y'), key('u')],
  'ぎょ' => [key('g'), key('y'), key('o')],
  'ぎぃ' => [key('g'), key('y'), key('i')],
  'ぎぇ' => [key('g'), key('y'), key('e')],
  'じゃ' => [key('z'), key('y'), key('a')],
  'じゅ' => [key('z'), key('y'), key('u')],
  'じょ' => [key('z'), key('y'), key('o')],
  'じぃ' => [key('j'), key('y'), key('i')],
  'じぇ' => [key('j'), key('y'), key('e')],
  'ぢゃ' => [key('d'), key('y'), key('a')],
  'ぢゅ' => [key('d'), key('y'), key('u')],
  'ぢょ' => [key('d'), key('y'), key('o')],
  'ぢぃ' => [key('d'), key('y'), key('i')],
  'ぢぇ' => [key('d'), key('y'), key('e')],
  'びゃ' => [key('b'), key('y'), key('a')],
  'びゅ' => [key('b'), key('y'), key('u')],
  'びょ' => [key('b'), key('y'), key('o')],
  'びぃ' => [key('b'), key('y'), key('i')],
  'びぇ' => [key('b'), key('y'), key('e')],
  'てぃ' => [key('t'), key('h'), key('i')],
  'てゅ' => [key('t'), key('h'), key('u')],
  'でぃ' => [key('d'), key('h'), key('i')],
  'でゅ' => [key('d'), key('h'), key('u')],
  'でゃ' => [key('d'), key('h'), key('a')],
  'でぇ' => [key('d'), key('h'), key('e')],
  'でょ' => [key('d'), key('h'), key('o')],
  'とぅ' => [key('t'), key('w'), key('u')],
  'どぅ' => [key('d'), key('w'), key('u')],
  'ヴぁ' => [key('v'), key('a')],
  'ヴぃ' => [key('v'), key('i')],
  'ヴぇ' => [key('v'), key('e')],
  'ヴぉ' => [key('v'), key('o')],
  'ヴゃ' => [key('v'), key('y'), key('a')],
  'ヴゅ' => [key('v'), key('y'), key('u')],
  'ヴょ' => [key('v'), key('y'), key('o')],
  'つぁ' => [key('t'), key('s'), key('a')],
  'つぃ' => [key('t'), key('s'), key('i')],
  'つぇ' => [key('t'), key('s'), key('e')],
  'つぉ' => [key('t'), key('s'), key('o')],
  'ふぁ' => [key('f'), key('a')],
  'ふぃ' => [key('f'), key('i')],
  'ふぇ' => [key('f'), key('e')],
  'ふぉ' => [key('f'), key('o')],
  'ふゅ' => [key('f'), key('y'), key('u')],
  'しぇ' => [key('s'), key('y'), key('e')],
  'ちぇ' => [key('t'), key('y'), key('e')],
  'いぇ' => [key('y'), key('e')],
  'うぁ' => [key('w'),key('h'),key('a')],
  'うぃ' => [key('w'),key('h'),key('i')],
  'うぇ' => [key('w'),key('h'),key('e')],
  'うぉ' => [key('w'),key('h'),key('o')],
  'りゃ' => [key('r'),key('y'),key('a')],
  'りぃ' => [key('r'),key('y'),key('i')],
  'りゅ' => [key('r'),key('y'),key('u')],
  'りぇ' => [key('r'),key('y'),key('e')],
  'りょ' => [key('r'),key('y'),key('o')],
  'ー' => [key(HYPHEN)],
  '、' => [key(COMMA)],
  '。' => [key(PERIOD)],
  '削' => [key_with_repeat(BACK_SPACE)],
  '→' => [key(RIGHT_ARROW)],
  '←' => [key(LEFT_ARROW)],
  '改' => [key(ENTER)],
  '英' => [key(ENG)],
  '仮' => [key(JPN)],
  '。改' => [key(PERIOD),key(ENTER)],


  #  '?' => [key_with_shift('slash')],
}.freeze

########################################

def main
  l = ARGV.shift
  if l && l.downcase == 'dvorak'
    k = Dvorak.new
  else
    k = Qwerty.new
  end

  now = Time.now.to_i
  puts JSON.pretty_generate(
    'title' => "Japanese NAGINATA STYLE (v11) for #{k.name} layout",
    'rules' => [
      {
        'description' => "Japanese NAGINATA STYLE (v11) for #{k.name} layout Build #{now} ",
        'manipulators' => [
          # 同時打鍵数の多いものから書く
          shiftkeydef(),#連続シフト用定義

          # ------------------------------
          # 4同時打鍵
          # W.I.P

          # ------------------------------
          # 3同時打鍵
          # 小書き： シフト半濁音同時押し
          three_keys(k.sp, k.ld[1], k.rm[1], 'ぁ'),
          three_keys(k.sp, k.ld[1], k.rm[2], 'ぃ'),
          three_keys(k.sp, k.ld[1], k.rm[3], 'ぅ'),
          three_keys(k.sp, k.ld[1], k.ru[4], 'ぇ'),
          three_keys(k.sp, k.ld[1], k.rd[0], 'ぉ'),
          three_keys(k.sp, k.ld[1], k.rm[4], 'ゃ'),
          three_keys(k.sp, k.ld[1], k.ru[3], 'ゅ'),
          three_keys(k.sp, k.ld[1], k.ru[2], 'ょ'),
          three_keys(k.sp, k.ld[1], k.rm[0], 'ゎ'),
          # シフト「りゅ」のみ「てゅ」に定義
          three_keys(k.sp, k.lu[2], k.ru[3],'てゅ'),
          three_keys(k.lm[3], k.rm[1], k.rm[4], 'ぎゃ'),
          three_keys(k.lu[1], k.rm[1], k.rm[4], 'じゃ'),
          three_keys(k.lm[0], k.rm[1], k.rm[4], 'ぢゃ'),
          three_keys(k.ld[3], k.rm[1], k.rm[4], 'びゃ'),
          three_keys(k.lm[3], k.rm[1], k.ru[3], 'ぎゅ'),
          three_keys(k.lu[1], k.rm[1], k.ru[3], 'じゅ'),
          three_keys(k.lm[0], k.rm[1], k.ru[3], 'ぢゅ'),
          three_keys(k.ld[3], k.rm[1], k.ru[3], 'びゅ'),
          three_keys(k.lm[3], k.rm[1], k.ru[2], 'ぎょ'),
          three_keys(k.lu[1], k.rm[1], k.ru[2], 'じょ'),
          three_keys(k.lm[0], k.rm[1], k.ru[2], 'ぢょ'),
          three_keys(k.ld[3], k.rm[1], k.ru[2], 'びょ'),
          # じゅぎゅが打ちにくいので、例外的に半濁音キーでもオーケーとする
          three_keys(k.lu[1], k.rd[1], k.ru[2], 'じょ'),
          three_keys(k.lu[1], k.rd[1], k.rm[4], 'じゃ'),
          three_keys(k.lu[1], k.rd[1], k.ru[3], 'じゅ'),
          three_keys(k.lm[3], k.rd[1], k.ru[2], 'ぎょ'),
          three_keys(k.lm[3], k.rd[1], k.rm[4], 'ぎゃ'),
          three_keys(k.lm[3], k.rd[1], k.ru[3], 'ぎゅ'),
          three_keys(k.lm[0], k.rd[1], k.ru[2], 'ぢょ'),
          three_keys(k.lm[0], k.rd[1], k.rm[4], 'ぢゃ'),
          three_keys(k.lm[0], k.rd[1], k.ru[3], 'ぢゅ'),
          three_keys(k.ld[3], k.rm[1], k.ru[2], 'びょ'),
          three_keys(k.ld[3], k.rm[1], k.ru[3], 'びゅ'),
          # 半濁音ゃゅょは「ぴ」のみ
          three_keys(k.ld[3], k.rd[1], k.ru[2], 'ぴょ'),
          three_keys(k.ld[3], k.rd[1], k.rm[4], 'ぴゃ'),
          three_keys(k.ld[3], k.rd[1], k.ru[3], 'ぴゅ'),
          three_keys(k.lu[2], k.rm[1], k.ru[3], 'でゅ'),
          three_keys(k.lu[1], k.rm[1], k.ru[4], 'じぇ'),
          three_keys(k.lm[0], k.rm[1], k.ru[4], 'ぢぇ'),
          three_keys(k.lu[2], k.rm[1], k.rm[2], 'でぃ'),
          three_keys(k.lm[2], k.rm[1], k.rm[3], 'どぅ'),
          #ツァ行は「う」「つ」が同じキーにあるためシフトを押しながら
          three_keys(k.sp, k.rm[3], k.rm[1], 'つぁ'),
          three_keys(k.sp, k.rm[3], k.rm[2], 'つぃ'),
          three_keys(k.sp, k.rm[3], k.ru[4], 'つぇ'),
          three_keys(k.sp, k.rm[3], k.rd[0], 'つぉ'),
          # ------------------------------
          # 2同時打鍵
          # 右手濁点
          two_keys(k.ru[1], k.lm[1], 'ざ'),
          two_keys(k.ru[3], k.lm[1], 'ず'),
          two_keys(k.ru[4], k.lm[1], 'べ'),
          two_keys(k.rm[0], k.lm[1], 'ぐ'),
          two_keys(k.rm[3], k.lm[1], 'づ'),
          two_keys(k.rd[0], k.lm[1], 'だ'),
          two_keys(k.rd[3], k.lm[1], 'ぶ'),

          # 左手濁点
          two_keys(k.lm[3], k.rm[1], 'ぎ'),
          two_keys(k.lu[2], k.rm[1], 'で'),
          two_keys(k.lu[1], k.rm[1], 'じ'),
          two_keys(k.ld[4], k.rm[1], 'ぼ'),
          two_keys(k.ld[2], k.rm[1], 'げ'),
          two_keys(k.lm[2], k.rm[1], 'ど'),
          two_keys(k.lm[1], k.rm[1], 'が'),
          two_keys(k.lm[0], k.rm[1], 'ぢ'),
          two_keys(k.lm[4], k.rm[1], 'ぜ'),
          two_keys(k.ld[3], k.rm[1], 'び'),
          two_keys(k.lu[3], k.rm[1], 'ば'),
          two_keys(k.ld[1], k.rm[1], 'ご'),
          two_keys(k.ld[0], k.rm[1], 'ぞ'),

          # 右手半濁音
          two_keys(k.ru[4], k.ld[1],'ぺ'),
          two_keys(k.rd[3], k.ld[1],'ぷ'),

          # 左手半濁音
          two_keys(k.ld[4], k.rd[1], 'ぽ'),
          two_keys(k.ld[3], k.rd[1], 'ぴ'),
          two_keys(k.lu[3], k.rd[1], 'ぱ'),

          # 拗音シフト やゆよと同時押しで、ゃゅょが付く

          two_keys(k.lm[3], k.rm[4], 'きゃ'),
          two_keys(k.lu[2], k.rm[4], 'りゃ'),
          two_keys(k.lu[1], k.rm[4], 'しゃ'),
          two_keys(k.lu[3], k.rm[4], 'みゃ'),
          two_keys(k.lm[2], k.rm[4], 'にゃ'),
          two_keys(k.lm[0], k.rm[4], 'ちゃ'),
          two_keys(k.ld[3], k.rm[4], 'ひゃ'),

          two_keys(k.lm[3], k.ru[3], 'きゅ'),
          two_keys(k.lu[2], k.ru[3], 'りゅ'),
          two_keys(k.lu[1], k.ru[3], 'しゅ'),
          two_keys(k.lu[3], k.ru[3], 'みゅ'),
          two_keys(k.lm[2], k.ru[3], 'にゅ'),
          two_keys(k.lm[0], k.ru[3], 'ちゅ'),
          two_keys(k.ld[3], k.ru[3], 'ひゅ'),

          two_keys(k.lm[3], k.ru[2], 'きょ'),
          two_keys(k.lu[2], k.ru[2], 'りょ'),
          two_keys(k.lu[1], k.ru[2], 'しょ'),
          two_keys(k.lm[2], k.ru[2], 'にょ'),
          two_keys(k.lm[0], k.ru[2], 'ちょ'),
          two_keys(k.ld[3], k.ru[2], 'ひょ'),

          two_keys(k.lu[3], k.ru[2], 'みょ'),
          two_keys(k.lu[3], k.rm[4], 'みゃ'),
          two_keys(k.lu[3], k.ru[3], 'みゅ'),

          two_keys(k.lu[1], k.ru[2], 'しょ'),
          two_keys(k.lu[1], k.rm[4], 'しゃ'),
          two_keys(k.lu[1], k.ru[3], 'しゅ'),
          two_keys(k.lm[3], k.ru[2], 'きょ'),
          two_keys(k.lm[3], k.rm[4], 'きゃ'),
          two_keys(k.lm[3], k.ru[3], 'きゅ'),
          two_keys(k.lm[2], k.ru[2], 'にょ'),
          two_keys(k.lm[2], k.rm[4], 'にゃ'),
          two_keys(k.lm[2], k.ru[3], 'にゅ'),
          two_keys(k.lm[0], k.ru[2], 'ちょ'),
          two_keys(k.lm[0], k.rm[4], 'ちゃ'),
          two_keys(k.lm[0], k.ru[3], 'ちゅ'),
          two_keys(k.ld[3], k.ru[2], 'ひょ'),
          two_keys(k.ld[3], k.rm[4], 'ひゃ'),
          two_keys(k.ld[3], k.ru[3], 'ひゅ'),

          # 外来音
          two_keys(k.lu[2], k.rm[2], 'てぃ'),
          two_keys(k.lm[2], k.rm[3], 'とぅ'),
          two_keys(k.lu[4], k.ru[4], 'ヴぇ'),
          two_keys(k.lu[4], k.rm[1], 'ヴぁ'),
          two_keys(k.lu[4], k.rm[2], 'ヴぃ'),
          two_keys(k.lu[4], k.rd[0], 'ヴぉ'),
          two_keys(k.lu[4], k.ru[3], 'ヴゅ'),

          # 右手領域の同時押し外来音
          two_keys(k.rm[3], k.rm[1], 'うぁ'),
          two_keys(k.rm[3], k.rm[2], 'うぃ'),
          two_keys(k.rm[3], k.ru[4], 'うぇ'),
          two_keys(k.rm[3], k.rd[0], 'うぉ'),

          two_keys(k.rd[3], k.rm[1], 'ふぁ'),
          two_keys(k.rd[3], k.rm[2], 'ふぃ'),
          two_keys(k.rd[3], k.ru[4], 'ふぇ'),
          two_keys(k.rd[3], k.rd[0], 'ふぉ'),
          two_keys(k.rd[3], k.ru[3], 'ふゅ'),

          two_keys(k.lu[1], k.ru[4], 'しぇ'),
          two_keys(k.lm[0], k.ru[4], 'ちぇ'),

          #特殊操作
          two_keys(k.ld[1], k.rd[1], '改'),
          two_keys_always(k.rm[0], k.rm[1], '仮'),#USモードでも効く定義
          two_keys(k.lm[1], k.lm[0], '英'),

          # ------------------------------
          # シフト(スペースキー)

          #shift_key(k.lu[0], ''),
          shift_key(k.lm[3], 'ね'),
          shift_key(k.lu[2], 'り'),
          shift_key(k.rd[2], 'む'),
          #shift_key(k.lu[4], ''),

          #shift_key(k.ru[0], ''),
          shift_key(k.ru[1], 'さ'),
          shift_key(k.ru[2], 'よ'),
          shift_key(k.ru[4], 'え'),
          shift_key(k.lu[1], 'め'),

          #shift_key(k.ld[0], ''),
          shift_key(k.lu[3], 'み'),
          shift_key(k.lm[2], 'に'),
          shift_key(k.lm[1], 'ま'),
          shift_key(k.lm[0], 'ち'),

          shift_key(k.rm[0], 'わ'),
          shift_key(k.rm[1], 'の'),
          shift_key(k.rm[2], 'も'),
          shift_key(k.rm[3], 'つ'),
          shift_key(k.rm[4], 'や'),

          shift_key(k.lm[4], 'せ'),
          #shift_key(k.ld[1], 'ひ'),
          shift_key(k.ld[2], 'を'),
          shift_key(k.ld[1], '、'),
          shift_key(k.ld[0], 'ぬ'),

          shift_key(k.rd[0], 'お'),
          shift_key(k.rd[1], '。改'),
          shift_key(k.ru[3], 'ゆ'),
          shift_key(k.rd[3], 'ふ'),
          #shift_key(k.rd[4], ''),

          # ------------------------------
          # 連続シフトシフト(スペースキー)

          #continuous_shift(k.lu[0], ''),
          continuous_shift(k.lm[3], 'ね'),
          continuous_shift(k.lu[2], 'り'),
          continuous_shift(k.rd[2], 'む'),
          #continuous_shift(k.lu[4], ''),

          #continuous_shift(k.ru[0], ''),
          continuous_shift(k.ru[1], 'さ'),
          continuous_shift(k.ru[2], 'よ'),
          continuous_shift(k.ru[4], 'え'),
          continuous_shift(k.lu[1], 'め'),

          #continuous_shift(k.ld[1], ''),
          continuous_shift(k.lu[3], 'み'),
          continuous_shift(k.lm[2], 'に'),
          continuous_shift(k.lm[1], 'ま'),
          continuous_shift(k.lm[0], 'ち'),

          continuous_shift(k.rm[0], 'わ'),
          continuous_shift(k.rm[1], 'の'),
          continuous_shift(k.rm[2], 'も'),
          continuous_shift(k.rm[3], 'つ'),
          continuous_shift(k.rm[4], 'や'),

          continuous_shift(k.lm[4], 'せ'),
          #continuous_shift(k.ld[0], ''),
          continuous_shift(k.ld[2], 'を'),
          continuous_shift(k.ld[1], '、'),
          continuous_shift(k.ld[0], 'ぬ'),

          continuous_shift(k.rd[0], 'お'),
          continuous_shift(k.rd[1], '。改'),
          continuous_shift(k.ru[3], 'ゆ'),
          continuous_shift(k.rd[3], 'ふ'),
          #continuous_shift(k.rd[4], ''),

          # ------------------------------
          # シフトなし(単打)

          normal_key(k.lu[4], 'ヴ'),
          normal_key(k.lm[3], 'き'),
          normal_key(k.lu[2], 'て'),
          normal_key(k.lu[1], 'し'),
          normal_key(k.lu[0], '←'),

          normal_key(k.ru[0], '→'),
          normal_key(k.ru[1], '削'),
          normal_key(k.ru[2], 'る'),
          normal_key(k.ru[3], 'す'),
          normal_key(k.ru[4], 'へ'),

          normal_key(k.ld[4], 'ほ'),
          normal_key(k.ld[2], 'け'),
          normal_key(k.lm[2], 'と'),
          normal_key(k.lm[1], 'か'),
          normal_key(k.lm[0], 'っ'),

          normal_key(k.rm[0], 'く'),
          normal_key(k.rm[1], 'あ'),
          normal_key(k.rm[2], 'い'),
          normal_key(k.rm[3], 'う'),
          normal_key(k.rm[4], 'ー'),

          normal_key(k.lm[4], 'ろ'),
          normal_key(k.ld[3], 'ひ'),
          normal_key(k.lu[3], 'は'),
          normal_key(k.ld[1], 'こ'),
          normal_key(k.ld[0], 'そ'),

          normal_key(k.rd[0], 'た'),
          normal_key(k.rd[1], 'な'),
          normal_key(k.rd[2], 'ん'),
          normal_key(k.rd[3], 'ら'),
          normal_key(k.rd[4], 'れ'),

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
      'key_code' => SPACEBAR,
    },
    'to' => [
      'set_variable'=>
        {'name' => 'shifted','value' => 1}
    ],
    'to_if_alone' => [
      'key_code' => SPACEBAR
    ],
    'to_after_key_up' => [
      'set_variable'=>
        {'name' => 'shifted','value' => 0}
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
          'key_code' => SPACEBAR,
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

main
