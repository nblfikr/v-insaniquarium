module main

import rand
import math
import time
import json
// const (
// 	guppy_growth_step = 1
// )

enum Direction {
	left
	right
}

struct Goldfish {
mut:
	pos							Position
	speed						f32
	direction					Direction
	last_change_direction		i64
	change_direction_interval	f32 = 2.5
	radians						f64
}

// TODO
// position is random
fn (a Aquarium) goldfish_create() Goldfish {
	mut g := Goldfish{
		pos: Position{
			x: rand.f32() * window_w
			y: rand.f32() * window_h
		}
		speed: 0.8,
		// direction: .left
	}

	d := math.fmod(rand.f32() * 10000, 361)
	g.radians = math.radians(d)

	if d <= 90 || d >= 270 {
		g.direction = .right
	} else {
		g.direction = .left
	}

	// println('goldfish creat1e')

	return g
}

fn (g Goldfish) is_time_to_change_direction() bool {
	return time.now().unix_time() - g.last_change_direction >= g.change_direction_interval
}

fn (mut g Goldfish) create_direction(pos Position) (f64, f64) {
	mut x := 0.0
	mut y := 0.0
	// for {
		// d := math.abs(rand.int_in_range(0, 360) or { 0} )
		// r := math.radians(d)

		x = g.speed * math.cos(g.radians)
		y = g.speed * math.sin(g.radians)

		// if is_inside_aquarium(Position{x: pos.x + x, y: pos.y + y}) {
		// 	// return x, y
		// 	break
		// }
	// }

	return x, y
}

fn (s AquariumSize) is_inside_aquarium(p Position) bool {
	return p.x >= 0 || p.y >= 0 || p.x <= window_w || p.y <= window_h
}

fn (g Goldfish) move(radians f64) Position {
	return Position{
		x: f32(g.speed * math.cos(radians))
		y: f32(g.speed * math.sin(radians))
	}
}

fn (mut g Goldfish) swim(s AquariumSize) {
	mut pos := Position{}
	// mut br := false
	for {
		if g.is_time_to_change_direction() {
			d := math.fmod(rand.f32() * 10000, 361)
			r := math.radians(d)
			pos = g.move(r)
			g.radians = r
			g.last_change_direction = time.now().unix_time()
		} else {
			pos = g.move(g.radians)
		}

		if s.is_inside_aquarium(pos) {
			break
		}
	}

	g.pos = Position{
		x: g.pos.x + pos.x
		y: g.pos.y + pos.y
	}

	// println('goldfish going to swim')
	println(json.encode(g.pos))
}

fn (mut g Goldfish) swim_to_eat(food Food) {
	if g.pos.find_distance(food.pos) <= g.speed {
		println('dimakan')
	} else {
		r := math.atan2((food.pos.y - g.pos.y), (food.pos.x - g.pos.x))
		p := g.move(r)
		g.pos = Position{
			x: g.pos.x + p.x
			y: g.pos.y + p.y
		}
		g.last_change_direction = time.now().unix_time()
	}
	// println('goldfish swim to food')
	println(json.encode(g.pos))
}
