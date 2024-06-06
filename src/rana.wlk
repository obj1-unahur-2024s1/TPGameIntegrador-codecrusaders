import wollok.game.*
import niveles.*

object rana {
	
	var property image = "rana.png"
	var property position = game.origin()
 	
	method compartePosicion(unaCosa){
		return self.position() == unaCosa.position()
	}
	
	method chocada(unaCosa) {
		if (self.compartePosicion(unaCosa)) {
			image = "ranaMuerta.png"
			game.schedule(200, { => game.stop()})			
		}
	}
	
	method ganoNivel1() {
		if (self.position() == nivelUno.llegada1().position() or self.position() == nivelUno.llegada2().position()){
			game.stop()
		}
	}
	
	method montada(unaCosa) {
		if (not self.compartePosicion(unaCosa)) {
			game.stop()			
		}
	}
	
}