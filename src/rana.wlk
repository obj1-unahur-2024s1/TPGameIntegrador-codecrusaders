import wollok.game.*
import niveles.*
import inicio.*
import objetosDeNiveles.*
import sonidos.*

object rana {
    var property image = "ranaU.png"
    var property position = game.origin()
    var property previousPosition = game.origin()
    var cantVidas = 3
    
    
    method perderVida() {
        cantVidas -= 1
        if( cantVidas.between(1, 3)){
        	nivel.nivelActual().vidas().cambiarVisual() // Actualiza el visual de las vidas
        	const p = new PerderVidas()
        	p.sonido().play()
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

class Mover{
	// Método para mover la rana
    method move(newPosition) {
        rana.previousPosition(rana.position())
        rana.position(newPosition)
    }
    
    method config(){
    	rana.ganoNivel()    	
        nivel.nivelActual().obstaculos().forEach{obstaculo => rana.chocadaConObstaculo(obstaculo)}
    	const m = new MovimientoRana()
    	m.sonido().play()
    	m.config()
    }

}


object moverArriba inherits Mover{
	method mover(){
		rana.image("ranaU.png")
		self.move(rana.position().up(1))
		if(rana.position().y() == 20){
        rana.position(rana.position().down(1))
    	}

    	self.config()
	}
}

object moverAbajo inherits Mover{
	method mover(){
		rana.image("ranaD.png")
		self.move(rana.position().down(1))
		if(rana.position().y() == -1){
        rana.position(rana.position().up(1))
        }
        
    	self.config()
	}
}

object moverDerecha inherits Mover{
	method mover(){
		rana.image("ranaR.png")
		self.move(rana.position().right(1))
		if(rana.position().x() == 20){
        rana.position(rana.position().left(1))
    	}

    	self.config()
	}
}

object moverIzquierda inherits Mover{
	method mover(){
		rana.image("ranaL.png")
		self.move(rana.position().left(1))
		if(rana.position().x() == -1){
        rana.position(rana.position().right(1))
    	}

    	self.config()
	}
} 
