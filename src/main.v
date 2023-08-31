module main

import gg
import gx
import os
import time

const (
	goldfish_size = 50
	window_w		= 1080
	window_h		= 1080
)

struct Player {
mut:
	name	string
}

struct Game {
mut:
	gg			&gg.Context = unsafe { nil }
	aquarium 	Aquarium
	background 	gg.Image
	food 		gg.Image
	start_time	i64
	player		Player
}

fn (mut game Game) set_player_name(name string) {
	game.player.name = name
}

fn (mut game Game) create_aquarium(w int, h int) {
	game.aquarium = Aquarium{
		size: AquariumSize{
			w: w,
			h: h
		}
	}
}

fn (mut game Game) start() {

	// render goldfish
	if game.aquarium.goldfish.len > 0 {
		for i in game.aquarium.goldfish {
			game.gg.draw_image_flipped(i.pos.x, i.pos.y, goldfish_size, goldfish_size, game.background)
		}
	}

	// render goldfish
	if game.aquarium.food.len > 0 {
		for f in game.aquarium.food {
			game.gg.draw_image_flipped(f.pos.x, f.pos.y, 20, 20, game.food)
		}
	}

	game.aquarium.run()
	// time.sleep(180 * time.millisecond)
}

fn main() {
	mut game := &Game{
		gg: 0
		start_time: time.now().unix_time()
	}
	game.gg = gg.new_context(
		bg_color: gx.green
		width: window_w
		height: window_h
		create_window: true
		window_title: 'aquarium'
		frame_fn: frame
		// event_fn: event
		init_fn: init_wrapper
		user_data: game
	)
	game.create_aquarium(window_w, window_h)
	game.gg.run()
	game.start()
}

fn frame(mut g Game) {
	g.gg.begin()
	g.start()
	g.gg.end()
}

fn init_wrapper(mut g Game) {
	g.init() or { panic(err) }
}

fn (mut g Game) init() ! {
	g.background = g.gg.create_image(os.resource_abs_path('assets/guppy1.png'))!
	g.food = g.gg.create_image(os.resource_abs_path('assets/food0.png'))!
	g.set_player_name('Im Gold Fish')
	g.create_aquarium(230, 780)
}