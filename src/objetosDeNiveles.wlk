import wollok.game.*
import rana.*
import inicio.*
import niveles.*

class Auto {
	var property position
	method image() = null
	method desplazarse(){}
}

class AutoBlanco inherits Auto {
  	override method image() = "autoAzul2.png"
  	
	override method desplazarse(){
		position = position.right(1) //asi se modifica siempre las posicones
 		if (self.position().x() == 20) { // me devuelve la posicion de x o y self.position().x/y()
			position = position.left(20)
		}
	}		
}

class AutoNegro inherits Auto {
  	override method image() = "autoRojo.png"
  	
	override method desplazarse(){
		position = position.left(1) //asi se modifica siempre las posicones
 		if (self.position().x() == -2) { // me devuelve la posicion de x o y self.position().x/y()
			position = position.right(20)
		}
	}		
}

object fondos{
	var property position = game.origin()
	var property image = nivel.nivelActual().fondo()
	
}

class Malito{
	var property position 
	method image() = "malito.png"
}

class Llegada{
	var property position 
	method image() = "llegada.png"
}

class TroncoDerechos {
	
}

class TroncoIzquierdo {
	
}

// configuracion de las vidas de la rana
class Vidas {
    var property position = game.at(17,17)
    const visuals = ["", "1vidas.png", "2vidas.png", "3vidas.png"]
    var property image = visuals.get(rana.vidasRestantes())
    
    method cambiarVisual(){
        image = visuals.get(rana.vidasRestantes())
    }
    
    method initialize(){
    	image = visuals.get(3)
    }
}

// objetos nivel desierto
class Tren{
	var property position
	method image() = null
	method desplazarse(){}
}

class Locomotora inherits Tren{
	override method image() = "tren1.png"
	override method desplazarse(){
		position = position.left(0.5) //asi se modifica siempre las posicones

		if (self.position().x() == -2) { // me devuelve la posicion de x o y self.position().x/y()
			position = position.right(10)
		}
	}
}

class Vagon inherits Tren{
	override method image() = "tren2.png"
	override method desplazarse(){
		position = position.left(0.5) //asi se modifica siempre las posicones

		if (self.position().x() == -2) { // me devuelve la posicion de x o y self.position().x/y()
			position = position.right(10)
		}
	}
}

class PlantaRodadora{
	var fotograma = 0
	
	var property position
	
	const visuals = ["rodadora1.png", "rodadora2.png", "rodadora3.png",
	"rodadora4.png", "rodadora5.png", "rodadora6.png", "rodadora7.png",
	"rodadora8.png"]
	
	var property image = visuals.get(self.fotogramaActual())
	
	method cambiarVisual(){
		image = visuals.get(self.fotogramaActual())
	}
	
	method cambiarFotograma(){
		fotograma += 1
		if(fotograma.between(0, 7)){
			nivel.nivelActual().planta().cambiarVisual()
		} else{
			fotograma = 1
			nivel.nivelActual().planta().cambiarVisual()
		}
	}
	
	method fotogramaActual() = fotograma
	
	method desplazarse(){
		self.cambiarFotograma()
		position = position.left(0.5) //asi se modifica siempre las posicones
	
		if (self.position().x() == 0) { // me devuelve la posicion de x o y self.position().x/y()
			position = position.right(8)
		}
	}
}


