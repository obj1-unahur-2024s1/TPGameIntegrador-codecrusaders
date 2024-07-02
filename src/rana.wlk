import wollok.game.*
import niveles.*
import inicio.*
import objetosDeNiveles.*
import sonidos.*

object rana {
    var property image = "ranaU.png"
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
            	image = "ranaDead.png"
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
		image = "ranaU.png"
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
    	image = "ranaU.png"
        self.move(position.up(1))
        self.ganoNivel()
        if(self.position().y() == 20){
        	position = position.down(1)
        }
        movimientoRana.sonar()
    }

    method moverAbajo() {
    	image = "ranaD.png"
        self.move(position.down(1))
        self.ganoNivel()
        if(self.position().y() == -1){
        	position = position.up(1)
        }
        movimientoRana.sonar()
    }

    method moverIzquierda() {
    	image = "ranaL.png"
        self.move(position.left(1))
        self.ganoNivel()
        if(self.position().x() == -1){
        	position = position.right(1)
        }
        movimientoRana.sonar()
    }

    method moverDerecha() {
     	image = "ranaR.png"
        self.move(position.right(1))
        self.ganoNivel()
        if(self.position().x() == 20){
        	position = position.left(1)
        }
        movimientoRana.sonar()
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
                    image = "ranaDead.png"
                    game.schedule(500, { => pantallaGameOver.config()} )
                } else {
                    self.position(game.origin())
                }
            }
        }
    }

}