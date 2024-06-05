import wollok.game.*
//Todo objeto que vayamoso a introducir debe cumplir con la imagen y posicion
object pepita {
	
	var property image = "imagen.png"
	var property position = game.att(3,3)
	var property energia = 0
	
	
	method comer(cantidad){
		energia = energia + cantidad * alpiste.energiaPorGramo()
		
	}
	
	method cuantaEnergiaMeQueda(){
		return "Me queda" +  energia + "energia"
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
	
	
}