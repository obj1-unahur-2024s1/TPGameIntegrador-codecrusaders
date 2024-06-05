import wollok.game.*
//Todo objeto que vayamoso a introducir debe cumplir con la imagen y posicion
object rana {
	
	var property image = "rana.webp"
	var property position = game.origin()
	var property energia = 0
	
	
	method comer(cantidad){
		energia = energia + cantidad * alpiste.energiaPorGramo()
	}
	
method cuantasVidasMeQuedan(){
		return "Me quedan" +  vida + "vidas"
	}
	 
	method image(){
		if(energia.beetwen(20,40)){return "image.png"}
		else if (energia > 40) { return "image.png"}
		else {return "image.png"}
	}
	
	method moveteALaDerecha(){
	  self.position(self.position().right(1))	
	}

	object alpiste(){
		method energiaPorGramo() * 2
	}
	
	
  	

  	method autoMovete(){
	  self.position(self.position().right(1))	
	}
}

	
}