import wollok.game.*
import rana.*
import objetosDeNiveles.*


class MovimientoRana {
	const property sonido = game.sound("select-sound-121244.mp3")
}

class Ambiente{
	const property sonido = game.sound("sonido-ambiente.mp3")

	method loop(){
		sonido.shouldLoop(false)
	}
}

class PerderNivel{
	const property sonido = game.sound("videogame-death-sound-43894.mp3")

	method loop(){
		sonido.shouldLoop(false)
	}
}

class PerderVidas {
	const property sonido = game.sound("negative_beeps-6008.mp3")
}