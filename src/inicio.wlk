import wollok.game.*
import niveles.*

object comienzo{
	method config(){
		game.title("Frogui")
		game.height(20)//largo
		game.width(20)//ancho
		game.addVisual(pantallaInicio)
		pantallaInicio.config()
	}
}

class Pantalla {
	var property position = game.at(0,0)
	method image() = null
	method config() {}
}

object pantallaInicio inherits Pantalla {
	override method image() = "pantallaInicio.png"
	override method config() {
		keyboard.enter().onPressDo{nivelUno.config()}
	}
}