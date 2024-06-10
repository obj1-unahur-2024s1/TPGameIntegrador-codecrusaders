import wollok.game.*
import niveles.*
import inicio.*
import objetosDeNiveles.*

object rana {
	
	var property image = "rana.png"
	var property position = game.origin()
	var vidas = 3
	
	method perderVida(){
		vidas -= 1
		if (vidas == 2){
			dosVidas.config()
		} else if(vidas == 1){
			unaVida.config()
		} else { 
			image = "ranaMuerta.png"
		}
	}
 	
	method compartePosicion(unaCosa){
		return self.position() == unaCosa.position()
	}
	
	method chocada(unaCosa) {
		if (self.compartePosicion(unaCosa)) {
			self.perderVida()
			if (vidas <= 0){ 
				game.schedule(300, { => pantallaGameOver.config()})
			} else {
				self.position(game.origin())
			}
		}
	}
	
	method ganoNivel1() {
		nivelUno.llegadas().forEach { llegada =>
			if ( self.position() == llegada.position()){
				game.stop()
			}	
		}
		
	}
	
	method montada(unaCosa) {
		if (not self.compartePosicion(unaCosa)) {
			game.stop()			
		}
	}

}