import wollok.game.*
import rana.*
import objetosDeNiveles.*

class Sonidos{
	var property sonido = game.sound("")
	
	method reproducir(){
		game.sound(sonido).play()
	}
	
	method detener(){
		game.sound(sonido).stop()
	}
	
	method reproducirLoop(){
		game.sound(sonido)
		sonido.shouldLoop(true)
		game.schedule(500, { sonido.play()} )
	}
}

object movimientoRana {
	method sonar(){
		game.sound("select-sound-121244.mp3").play()
		
	}
}

object ambiente{
	var suena = false

	method fondo(){
		const musica = game.sound("sonido-ambiente.mp3")
		
		if(suena){
			musica.stop()
			suena = false
		}
		musica.shouldLoop(true)
		game.schedule(500, { musica.play()} )
		suena = true

	}
	
}

object perderNivel inherits Sonidos{
	
	"videogame-death-sound-43894.mp3"
}

objecterderVidas {
   
    
     
	
	const property sonido = game.sound("negative_beeps-6008.mp3")
}