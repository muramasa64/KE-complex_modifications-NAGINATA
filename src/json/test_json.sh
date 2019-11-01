#!/bin/bash

# Default (QWERTY)
ruby ./japanese_naginata.json.rb > qwerty.json
diff -u qwerty.json ../../docs/json/japanese_naginata.json
rm -f qwerty.json

# Default (QWERTY, Horizonal)
ruby ./japanese_naginata.json.rb h > qwerty_h.json
diff -u qwerty_h.json ../../docs/json/japanese_naginata_h.json
rm -f qwerty_h.json

# Default (QWERTY, Vertical)
ruby ./japanese_naginata.json.rb v > qwerty_v.json
diff -u qwerty_v.json ../../docs/json/japanese_naginata.json
rm -f qwerty_v.json

# Default (QWERTY, Horizonal, T/Y key Exchange)
ruby ./japanese_naginata.json.rb h m > qwerty_h_m.json
diff -u qwerty_h_m.json ../../docs/json/japanese_naginata_h_m.json
rm -f qwerty_h_m.json

# Default (QWERTY, Vertical, T/Y Key Exchange)
ruby ./japanese_naginata.json.rb v m > qwerty_v_m.json
diff -u qwerty_v_m.json ../../docs/json/japanese_naginata_m.json
rm -f qwerty_v_m.json

# Dvorak, Horizonal
ruby ./dvorak_japanese_naginata.json.rb dh > dvorak_h.json
diff -u dvorak_h.json ../../docs/json/dvorak_japanese_naginata_h.json
rm -f drovak_h.json

# Drovak, Vertical
ruby ./dvorak_japanese_naginata.json.rb dv > dvorak_v.json
diff -u drovak_v.json ../../docs/json/dvorak_japanese_naginata.json
rm -f drovak_v.json

# Dvorak, Horizonal, T/Y key Exchange
ruby ./dvorak_japanese_naginata.json.rb dh m > drovak_h_m.json
diff -u drovak_h_m.json ../../docs/json/dvorak_japanese_naginata_h_m.json
rm -f drovak_h_m.json

# Dvorak, Vertical, T/Y Key Exchange
ruby ./dvorak_japanese_naginata.json.rb dv m > drovak_v_m.json
diff -u drovak_v_m.json ../../docs/json/dvorak_naginata_m.json
rm -f drovak_v_m.json
