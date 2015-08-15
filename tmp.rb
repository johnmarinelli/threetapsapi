require_relative 'lib/three_taps_api'

ThreeTapsAPI.rec_hash_to_openstruct({ a: 1 })
a = ThreeTapsAPI.rec_hash_to_openstruct({ a: 1, b: { c: 2 } })
b = ThreeTapsAPI.rec_hash_to_openstruct({ a: 1, b: { c: 2 }, d: { e: { f: 3 } } })
p a.b.c
p b.d.e.f
