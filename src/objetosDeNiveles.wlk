import wollok.game.*

class Auto {
	var property position
	method image() = null
	method desplazarse(){}
}

class AutoBlanco inherits Auto {
  	override method image() = "auto1.png"
  	
	override method desplazarse(){
		position = position.right(1) //asi se modifica siempre las posicones
 		if (self.position().x() == 20) { // me devuelve la posicion de x o y self.position().x/y()
			position = position.left(20)
		}
	}		
}

class AutoNegro inherits Auto {
  	override method image() = "auto2.png"
  	
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
class Vidas{
	var property position = game.at(17,17)
	method image() = ""
	method config(){}
	
}

object tresVidas inherits Vidas{
	override method image() = "3vidas.png"
}


object dosVidas inherits Vidas{
	override method image() = "2vidas.png"
	override method config(){
		game.removeVisual(tresVidas)
		game.addVisual(self)
	}
}

object unaVida inherits Vidas{
	override method image() = "1vidas.png"
	override method config(){
		game.removeVisual(dosVidas)
		game.addVisual(self)
	}
}



