import wollok.game.*

class AutoBlanco {
	var property position
  	method image() = "auto1.png"
  	
	method desplazarse(){
		position = position.right(1)
	}		
}

class AutoNegro {
	var property position
  	method image() = "auto2.png"
  	
	method desplazarse(){
		position = position.left(1)
	}	
}
object fondo{
	var property position = game.origin()
	method image() = "fondo1.png"
	
}
class TroncoDerechos {
	
}

class TroncoIzquierdo {
	
}