import wollok.game.*

class AutoBlanco {
	var property position
  	method image() = "auto1.png"
  	
	method desplazarse(){
		position = position.right(1) //asi se modifica siempre las posicones
 		if (self.position().x() == 20) { // me devuelve la posicion de x o y self.position().x/y()
			position = position.left(20)
		}
	}		
}

class AutoNegro {
	var property position
  	method image() = "auto2.png"
  	
	method desplazarse(){
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