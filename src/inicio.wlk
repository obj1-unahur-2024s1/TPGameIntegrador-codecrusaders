import wollok.game.*
import niveles.*
import rana.*

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
	
	method image() = fotogramas.get(self.fotogramaActual())
	
	method cambiarVisual() = self.image()
	
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
	
	method config() {}
}

object pantallaInicio inherits Pantalla {	
	
	override method config() {
		fotogramas.add("pantallaInicio.png")
		fotogramas.add("pantallaInicio2.png")
		
		game.onTick(200, "animarFondo", {self.cambiarFotograma()})
		keyboard.enter().onPressDo{
			game.removeTickEvent("animarFondo")
			pantallaEscenarios.config()
		}
	}
}

object pantallaEscenarios inherits Pantalla {

	override method config() {
		game.clear()
		if (not game.hasVisual(self)){
			game.addVisual(self)
		}
		fotogramas.add("pantallaEscenarios.jpg")
		fotogramas.add("pantallaEscenarios2.jpg")
		
		game.onTick(200, "animarFondo", {self.cambiarFotograma()})
		keyboard.c().onPressDo{
			nivel.configurarEscenarioCiudad()
			nivel.nivelActual().config()
		}
		
		keyboard.d().onPressDo{
			nivel.configurarEscenarioDesierto()
			nivel.nivelActual().config()
		}
	}
}


object pantallaGameOver inherits Pantalla {
	override method image() = "pantallaGameOver.jpg"
	override method config(){
		if (not game.hasVisual(self)){
			game.addVisual(self)
		}
		keyboard.r().onPressDo{
			game.clear()
			nivel.nivelActual().config()
		}
	}
}
