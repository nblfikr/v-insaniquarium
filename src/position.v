module main

import math
import rand

struct Position {
	x f32
	y f32
}

fn (s AquariumSize) random_position() Position {
	return Position{
		x: rand.f32() * s.w
		y: rand.f32() * s.h
	}
}

fn (p Position) find_distance(t Position) f32 {
	x := p.x - t.x
	y := p.y - t.y
	return f32(math.sqrt(x * x + y * y))
}

fn (p Position) equals(t Position) bool {
	return p == t
}