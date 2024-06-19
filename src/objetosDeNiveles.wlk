import wollok.game.*
import rana.*
import inicio.*

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

object fondo{
	var property position = game.origin()
	method image() = "fondo1.png"
	
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




