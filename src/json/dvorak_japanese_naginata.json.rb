#!/usr/bin/env ruby
#
# You can generate json for dvorak layout by executing the following command on Terminal.
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

main
