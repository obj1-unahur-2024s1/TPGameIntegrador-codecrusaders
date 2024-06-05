import wollok.game.*

object auto{
	
	var property position = game.origin()
  	method image() = "autitoAzul.png"
  	
	method desplazarse(){
		position = position.right(1)
	}	
	
}

object auto2{
	
	var property position = game.at(14,1)
  	method image() = "autitoRojo.png"
  	
	method desplazarse(){
		position = position.left(1)
	}	
	
}
