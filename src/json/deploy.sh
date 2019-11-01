#!/bin/bash

# Dvorak, Horizonal
ruby ./dvorak_japanese_naginata.json.rb dh > dvorak_h.json
mv dvorak_h.json ~/.config/karabiner/assets/complex_modifications

# Dvorak, Vertical
ruby ./dvorak_japanese_naginata.json.rb dh > dvorak.json
mv dvorak.json ~/.config/karabiner/assets/complex_modifications

# Dvorak, Horizonal T/Y Key Exchange
ruby ./dvorak_japanese_naginata.json.rb dh m > dvorak_h_m.json
mv dvorak_h_m.json ~/.config/karabiner/assets/complex_modifications

# Dvorak, Vertical T/Y Key Exchange
ruby ./dvorak_japanese_naginata.json.rb dh m > dvorak_v_m.json
mv dvorak_v_m.json ~/.config/karabiner/assets/complex_modifications
