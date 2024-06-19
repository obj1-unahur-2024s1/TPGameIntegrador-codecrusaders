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
	method image() = null
	method config() {}
}

object pantallaInicio inherits Pantalla {
	override method image() = "pantallaInicio.png"
	override method config() {
		keyboard.enter().onPressDo{pantallaEscenarios.config()}
	}
}

object pantallaEscenarios inherits Pantalla {
	override method image() = "pantallaGameOver.jpg"
	override method config() {
		game.clear()
		if (not game.hasVisual(self)){
			game.addVisual(self)
		}

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
