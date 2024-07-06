import wollok.game.*
import rana.*
import inicio.*
import niveles.*

class Auto {
	var property position
	const property esObstaculo = true
	const property esMeta = false
	method image() = null
	method desplazarse(){}
}

class AutoDerecha inherits Auto {
  	override method image() = "autoblanco.png"
  	
	override method desplazarse(){
		position = position.right(1) //asi se modifica siempre las posicones
 		if (self.position().x() > 20) { // me devuelve la posicion de x o y self.position().x/y()
			position = position.left(21)
		}
	}		
}

class AutoIzquierda inherits Auto {
  	override method image() = "autoverde.png"
  	
	override method desplazarse(){
		position = position.left(1) //asi se modifica siempre las posicones
 		if (self.position().x() < -1) { // me devuelve la posicion de x o y self.position().x/y()
			position = position.right(21)
		}
	}		
}

class Camioneta inherits AutoIzquierda{
	override method image() = "camioneta.png"
}

class AutoRojo inherits AutoDerecha{
	override method image() = "autoRojo.png"
}

object fondos{
	var property position = game.origin()
	const property esObstaculo = false
	const property esMeta = false
	var property fondos = ["fondoCiudad.png", "fondoCiudad2.png", "fondoDesierto.png", "fondoDesierto2.png"]
	var property image = ""
	
	method setImage(){
		image = fondos.get(nivel.nivelActual().fondo())
	}
}


class Llegada{
	var property position 
	const property esObstaculo = false
	const property esMeta = true
	var activa = true
	
	method image() = "llegada.png"
	
    method esMeta() {
        return activa
    }

    method desactivar() {
        activa = false
        // Ocultar o cambiar el estado visual de la meta
    }

    method reset() {
        activa = true
        // Reiniciar el estado visual de la meta
    }
}

class RanaMeta{
    // Representa una rana que se queda en la meta alcanzada
    var property position
    const property image = "ranaD.png"
    const property esMeta = false
}


class Nenufar {
	var property position
	const property esObstaculo = false
	const property esMeta = false
	
	method image() = "nenufar.png"

   	method reaparecerEnFilaEspecifica(fila){ 
   		position = game.at(1.randomUpTo(game.width()-1).truncate(0), fila)
   	}
}


class Troncos{
	var property position
	const property esObstaculo = false
	const property esMeta = false
	
	method image() = ""
	
	method derecha(){
		position = position.right(1) //asi se modifica siempre las posicones
 		if (self.position().x() == 20) { // me devuelve la posicion de x o y self.position().x/y()
			position = position.left(21)
		}
	}
	
	method izquierda(){
		position = position.left(1) //asi se modifica siempre las posicones
 		if (self.position().x() == -1) { // me devuelve la posicion de x o y self.position().x/y()
			position = position.right(21)
		}
	}
	
	method desplazarse(){}
}

class TroncoDerecha inherits Troncos {
	override method image() = "tronco1.png"
	override method desplazarse(){
		self.derecha()
	}	
}

class TroncoDerecha2 inherits TroncoDerecha{
	override method image() = "tronco2.png"
}


class TroncoIzquierda inherits Troncos{
	override method image() = "tronco1.png"
	override method desplazarse(){
		self.izquierda()
	}
}

class TroncoIzquierda2 inherits TroncoIzquierda{
	override method image() = "tronco2.png"
}

object estrellas {
	var property position
	
	const property esMeta = false
	
	var property image = "estrella.png"
	
	method esObstaculo() = false
  	
  	method reaparecerAlAzar() {
        const x = 1.randomUpTo(game.width()-1).truncate(0)
        const y = 4.randomUpTo(game.height()-1).truncate(0)
        position = game.at(x,y)
    }
}

object contador {
	var property position = game.at(2,17)
	method text() = "Estrellas juntadas: " + (nivel.puntos())
}

// obstaculos

class Obstaculos {
    var property position
    const property esObstaculo = false
    const property esMeta = false
    method image() = null
}

class Valla inherits Obstaculos {
    override method image() = "valla.png"
}

class CartelStop inherits Obstaculos {
    override method image() = "cartelstop.png"
}

// configuracion de las vidas de la rana
class Vidas {
    var property position = game.at(19,19)
    const visuals = ["", "1vidas.png", "2vidas.png", "3vidas.png"]
    var property image = visuals.get(rana.vidasRestantes())
    
    method cambiarVisual(){
        image = visuals.get(rana.vidasRestantes())
    }
    
    method initialize(){
    	image = visuals.get(3)
    }
}

// objetos nivel desierto
class Tren{
	var property position
	const property esMeta = false
	const property esObstaculo = true
	method image() = null
	method desplazarse(){
		
	}
}

class Locomotora inherits Tren{
	override method image() = "tren.png"
	override method desplazarse(){
		position = position.right(2) //asi se modifica siempre las posicones

		if (self.position().x() > 21) { // me devuelve la posicion de x o y self.position().x/y()
			position = position.left(22)
		}
	}
}

class Vagon inherits Tren{
	override method image() = "vagon.png"
	override method desplazarse(){
		position = position.right(2) //asi se modifica siempre las posicones

		if (self.position().x() > 20) { // me devuelve la posicion de x o y self.position().x/y()
			position = position.left(22)
		}
	}
}

class PlantaRodadora {
    var fotograma = 0
    var property position
    const property esObstaculo = true
    const property esMeta = false
    
    const visuals = ["rodadora1.png", "rodadora2.png", "rodadora3.png", "rodadora4.png", 
                     "rodadora5.png", "rodadora6.png", "rodadora7.png", "rodadora8.png"]
    
    var property image = visuals.get(self.fotogramaActual())
    
    method cambiarVisual() {
        image = visuals.get(self.fotogramaActual())
    }
    
    method cambiarFotograma() {
        fotograma += 1
        if (fotograma > 7) {
            fotograma = 0
        }
        self.cambiarVisual()
    }
    
    method fotogramaActual() = fotograma
    
    method desplazarse() {
        self.cambiarFotograma()
        position = position.left(0.5)
        
        if (self.position().x() == -1) {
            position = position.right(21)
        }
    }
}


class Cactus{
	var property position 
	const property esObstaculo = true
	const property esMeta = false
	method image() = "cactus2.png"
}