import wollok.game.*
import niveles.*
import inicio.*
import objetosDeNiveles.*

object rana {
    var property image = "rana.png"
    var property position = game.origin()
    var previousPosition = game.origin()
    var cantVidas = 3
    
    
    method perderVida() {
        cantVidas -= 1
        if( cantVidas.between(1, 3)){
        	nivel.nivelActual().vidas().cambiarVisual() // Actualiza el visual de las vidas
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
    
    method chocadaConObstaculo(unObstaculo) {
        if (self.compartePosicion(unObstaculo)) {
            // Revertir a la posición anterior
            self.position(previousPosition)
        }
    }
    
	
	method ganoNivel() {
		nivel.nivelActual().llegadas().forEach { llegada =>
			if ( self.position() == llegada.position()){
				nivel.aumentarNivel()
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
	
	// Método para mover la rana
    method move(newPosition) {
        previousPosition = position
        position = newPosition
    }

    // Métodos para mover la rana en diferentes direcciones
    method moverArriba() {
        self.move(position.up(1))
        self.ganoNivel()
        if(self.position().y() == 21){
        	position = position.down(1)
        }
    }

    method moverAbajo() {
        self.move(position.down(1))
        self.ganoNivel()
        if(self.position().y() == -1){
        	position = position.up(1)
        }
    }

    method moverIzquierda() {
        self.move(position.left(1))
        self.ganoNivel()
        if(self.position().x() == -1){
        	position = position.right(1)
        }
    }

    method moverDerecha() {
        self.move(position.right(1))
        self.ganoNivel()
        if(self.position().x() == 21){
        	position = position.left(1)
        }
    }
	
	// Método para verificar si la rana está en una fila sin estar sobre un nenúfar
    method comprobarFilaNenufares(fila, nenufares) {
        if (self.position().y() == fila) {
            var sobreNenufar = false
            nenufares.forEach { nenufar =>
                if (self.compartePosicion(nenufar)) {
                    sobreNenufar = true
                }
            }
            if (not sobreNenufar) {
                self.perderVida()
                if (cantVidas <= 0) {
                    image = "ranaMuerta.png"
                    game.schedule(500, { => pantallaGameOver.config()} )
                } else {
                    self.position(game.origin())
                }
            }
        }
    }

}