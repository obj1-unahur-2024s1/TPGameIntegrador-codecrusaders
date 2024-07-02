import wollok.game.*
import rana.*
import inicio.*
import niveles.*

class Auto {
	var property position
	method image() = null
	method desplazarse(){}
}

class AutoDerecha inherits Auto {
  	override method image() = "autoAzul1.png"
  	
	override method desplazarse(){
		position = position.right(1) //asi se modifica siempre las posicones
 		if (self.position().x() > 20) { // me devuelve la posicion de x o y self.position().x/y()
			position = position.left(21)
		}
	}		
}

class AutoIzquierda inherits Auto {
  	override method image() = "autoVerde1.png"
  	
	override method desplazarse(){
		position = position.left(1) //asi se modifica siempre las posicones
 		if (self.position().x() < -1) { // me devuelve la posicion de x o y self.position().x/y()
			position = position.right(21)
		}
	}		
}

object fondos{
	var property position = game.origin()
	var property fondos = ["fondoCiudad.png", "fondoCiudad2.png", "fondoDesierto.png", "fondoDesierto2.png"]
	var property image = ""
	
	method setImage(){
		image = fondos.get(nivel.nivelActual().fondo())
	}
}


class Llegada{
	var property position 
	method image() = "llegada.png"
}


class Nenufar {
	var property position
	method image() = "nenufar.png"	
}


class Troncos{
	var property position
	
	method image() = ""
	
	method derecha(){
		position = position.right(1) //asi se modifica siempre las posicones
 		if (self.position().x() == 20) { // me devuelve la posicion de x o y self.position().x/y()
			position = position.left(20)
		}
	}
	
	method izquierda(){
		position = position.left(1) //asi se modifica siempre las posicones
 		if (self.position().x() == -2) { // me devuelve la posicion de x o y self.position().x/y()
			position = position.right(20)
		}
	}
	
	method desplazarse(){}
}

class TroncoDerecha inherits Troncos {
	override method image() = "tronco1.png"
	override method desplazarse(){
		self.derecha()
	}	
}

class TroncoDerecha2 inherits TroncoDerecha{
	override method image() = "tronco2.png"
}


class TroncoIzquierda inherits Troncos{
	override method image() = "tronco1.png"
	override method desplazarse(){
		self.izquierda()
	}
}

class TroncoIzquierda2 inherits TroncoIzquierda{
	override method image() = "tronco2.png"
}


// obstaculos

class Obstaculos {
    var property position
    method image() = null
}

class Valla inherits Obstaculos {
    override method image() = "valla.png"
}

class CartelStop inherits Obstaculos {
    override method image() = "cartelstop.png"
}

// configuracion de las vidas de la rana
class Vidas {
    var property position = game.at(19,19)
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
	method desplazarse(){
		
	}
}

class Locomotora inherits Tren{
	override method image() = "tren.png"
	override method desplazarse(){
		position = position.right(2) //asi se modifica siempre las posicones

		if (self.position().x() > 21) { // me devuelve la posicion de x o y self.position().x/y()
			position = position.left(22)
		}
	}
}

class Vagon inherits Tren{
	override method image() = "vagon.png"
	override method desplazarse(){
		position = position.right(2) //asi se modifica siempre las posicones

		if (self.position().x() > 20) { // me devuelve la posicion de x o y self.position().x/y()
			position = position.left(22)
		}
	}
}

class PlantaRodadora {
    var fotograma = 0
    var property position
    
    const visuals = ["rodadora1.png", "rodadora2.png", "rodadora3.png", "rodadora4.png", 
                     "rodadora5.png", "rodadora6.png", "rodadora7.png", "rodadora8.png"]
    
    var property image = visuals.get(self.fotogramaActual())
    
    method cambiarVisual() {
        image = visuals.get(self.fotogramaActual())
    }
    
    method cambiarFotograma() {
        fotograma += 1
        if (fotograma > 7) {
            fotograma = 0
        }
        self.cambiarVisual()
    }
    
    method fotogramaActual() = fotograma
    
    method desplazarse() {
        self.cambiarFotograma()
        position = position.left(0.5)
        
        if (self.position().x() == -1) {
            position = position.right(21)
        }
    }
}


class Cactus{
	var property position 
	method image() = "cactus2.png"
}