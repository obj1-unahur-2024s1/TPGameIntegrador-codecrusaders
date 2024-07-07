import wollok.game.*
import niveles.*
import rana.*
import objetosDeNiveles.*
import sonidos.*

object comienzo{
	method config(){
		game.title("Frogui")
		game.height(20)//largo
		game.width(20)//ancho
		game.cellSize(50)
		game.addVisual(pantallaInicio)
		pantallaInicio.config()
	}
}

class Pantalla {
	var property position = game.origin()
	var fotograma = 0
	const fotogramas = []
	var property image 

	method cambiarVisual(){
		image = fotogramas.get(self.fotogramaActual())
	}
	
	method fotogramaActual() = fotograma
	
	method cambiarFotograma(){
		return if(fotograma == 0){
			fotograma += 1
			self.cambiarVisual()
		} else{
			fotograma = 0
			self.cambiarVisual()
		}
	}
	
	method config() {
		game.clear()
		if(not game.hasVisual(self)){
			game.addVisual(self)
		}
		
		self.agregarFotograma()
		
		game.onTick(100, "cambiarFotograma" , {self.cambiarFotograma()})
	}

	method agregarFotograma(){}
}

object pantallaInicio inherits Pantalla(image = "pantallaInicio.png") {	
	
	override method agregarFotograma(){
		fotogramas.add("pantallaInicio.png")
		fotogramas.add("pantallaInicio2.png")
	}
	
	override method config() {
		super()

		keyboard.enter().onPressDo{
			pantallaEscenarios.config()
		}
		keyboard.e().onPressDo{ game.stop() }
	}
}

object pantallaEscenarios inherits Pantalla(image = "pantallaEscenarios.png") {
	override method agregarFotograma(){
		fotogramas.add("pantallaEscenarios.png")
		fotogramas.add("pantallaEscenarios2.png")
	}
	
	override method config() {
		super()
		
		const ambiente = new Ambiente()
		
		keyboard.c().onPressDo{
			nivel.configurarEscenarioCiudad()
			
			nivel.nivelActual().config()
			if(!ambiente.sonido().played()){
				ambiente.sonido().play()
				ambiente.config()
			}
		
		}
		
		keyboard.d().onPressDo{
			nivel.configurarEscenarioDesierto()
			
			nivel.nivelActual().config()
			if(!ambiente.sonido().played()){
				ambiente.sonido().play()
				ambiente.config()
			}
		
		}
	}
}


object pantallaGameOver inherits Pantalla(image = "pantallaGameOver.png") {
	override method agregarFotograma(){
		fotogramas.add("pantallaGameOver.jpg")
		fotogramas.add("pantallaGameOver2.jpg")
	}
	
	override method config(){
		super()
		
		const gameOver = new PerderNivel()
		
		if(!gameOver.sonido().played()){
			gameOver.sonido().play()
			gameOver.config()
		}
		
		keyboard.r().onPressDo{ 
			nivel.nivelActual().configurarPuntos() 
			nivel.nivelActual().config()
		}
	}
}


object pantallaWin inherits Pantalla(image = "fondoWin.png") {
	override method agregarFotograma(){
		fotogramas.add("fondoWin.png")
		fotogramas.add("fondoWin2.png")
	}
	
	override method config(){
		super()
	
		game.schedule(300, {
			if (not game.hasVisual(puntajeFinal)){
				game.addVisual(puntajeFinal)
			}
		})
		
		

		keyboard.enter().onPressDo{ game.stop() }
	}
}

object puntajeFinal{
	const property position = game.at(16, 1)
	method text() = (nivel.puntos()).toString()
	method textColor() = "#000000"
}
