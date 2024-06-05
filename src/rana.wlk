import wollok.game.*

object rana {
	
	var property image = "rana.png"
	var property position = game.origin()
	var property vidas = 3 
 	
	method compartePosicion(unaCosa){
		return self.position() == unaCosa.position()
	}
	
}