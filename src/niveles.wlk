import wollok.game.*
import rana.*
import objetosDeNiveles.*

object nivelUno {
	const property auto1 = new AutoBlanco(position = game.at(0,6)) 
	const property auto2 = new AutoNegro(position = game.at(20,8))
	const property auto3 = new AutoBlanco(position = game.at(0,10))
	const property auto4 = new AutoNegro(position = game.at(20,12))
	const property auto5 = new AutoBlanco(position = game.at(0,14))
	const property malito1= new Malito(position = game.at(2,16))
	const property llegada1= new Llegada(position = game.at(5,18))
	const property malito2= new Malito(position = game.at(9,16))
	const property llegada2= new Llegada(position = game.at(13,18))
	const property malito3= new Malito(position = game.at(17,16))
	
	method config(){		
		game.clear()
		
		game.addVisual(fondo)
		
		game.addVisualCharacter(rana) // Mueve la rana 
		
		// Añade los autos
		game.addVisual(auto1)
		game.addVisual(auto2)
		game.addVisual(auto3)
		game.addVisual(auto4)
		game.addVisual(auto5)
		game.addVisual(malito1)
		game.addVisual(malito2)
		game.addVisual(malito3)
		game.addVisual(llegada1)
		game.addVisual(llegada2)
		
		// Mueve los autos constantemente
		game.onTick(100,"moverAuto",{auto1.desplazarse()})
		game.onTick(150,"moverAuto",{auto2.desplazarse()})
		game.onTick(85,"moverAuto",{auto3.desplazarse()})
		game.onTick(200,"moverAuto",{auto4.desplazarse()})
		game.onTick(115,"moverAuto",{auto5.desplazarse()})
		
		// Se fija si la rana chocó o se quemó
		game.onTick(1, "ranaChocada", {rana.chocada(auto1)})
		game.onTick(1, "ranaChocada", {rana.chocada(auto2)})
		game.onTick(1, "ranaChocada", {rana.chocada(auto3)})
		game.onTick(1, "ranaChocada", {rana.chocada(auto4)})
		game.onTick(1, "ranaChocada", {rana.chocada(auto5)})
		game.onTick(1, "ranaQuemada", {rana.chocada(malito1)})
		game.onTick(1, "ranaQuemada", {rana.chocada(malito2)})
		game.onTick(1, "ranaQuemada", {rana.chocada(malito3)})
		
		// Se fija si la rana llegó
		game.onTick(1, "ranaGanadora", {rana.ganoNivel1()})
	}
}




