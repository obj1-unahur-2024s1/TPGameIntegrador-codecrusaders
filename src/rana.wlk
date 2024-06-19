import wollok.game.*
import niveles.*
import inicio.*
import objetosDeNiveles.*

object rana {
    var property image = "rana.png"
    var property position = game.origin()
    var cantVidas = 3
    
    
    method perderVida() {
        cantVidas -= 1
        if( cantVidas.between(1, 3)){
        	nivelUno.vidas().cambiarVisual() // Actualiza el visual de las vidas
        }
    }
 
    method vidasRestantes() = cantVidas
    
    method compartePosicion(unaCosa) {
        return self.position() == unaCosa.position()
    }
    
    method chocada(unaCosa) {
        if (self.compartePosicion(unaCosa)) {
            self.perderVida()
            if (cantVidas <= 0) {
            	image = "ranaMuerta.png"
                game.schedule(500, { => pantallaGameOver.config()} )
            } else {
                self.position(game.origin())
            }
        }
    }
    
	
	method ganoNivel() {
		nivelUno.llegadas().forEach { llegada =>
			if ( self.position() == llegada.position()){
				nivel.aumentarNivel()
				nivel.siguiente()
			}	
		}
	}
	
	method montada(unaCosa) {
		if (not self.compartePosicion(unaCosa)) {
			game.stop()			
		}
	}
	
	method initialize(){
		image = "rana.png"
    	position = game.origin()
    	cantVidas = 3
	}

}