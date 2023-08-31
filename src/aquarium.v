module main

struct AquariumSize {
	w			int
	h			int
}

struct Aquarium {
	size 		AquariumSize
mut:
	goldfish 	[]Goldfish
	food 		[]Food
}

fn aquarium(w int, h int) Aquarium {
	return Aquarium{
		size: AquariumSize{
			w: w
			h: h
		}
	}
}

// adding only one goldfish
fn (mut a Aquarium) add_goldfish() {
	a.goldfish << a.goldfish_create()
}

// remove only one goldfish
fn (mut a Aquarium) remove_goldfish(i int) {
	a.goldfish.delete(i)
}

fn (mut a Aquarium) prepare() {
	a.add_goldfish()
	a.food << Food{
		pos: Position{
			x: 220
			y: 220
		}
	}
}

fn (mut a Aquarium) run() {
	if a.goldfish.len <= 0 {
		a.prepare()
	}
	for mut g in a.goldfish {
		g.swim(a.size)
		// g.swim_to_eat(a.food[0])
	}
}