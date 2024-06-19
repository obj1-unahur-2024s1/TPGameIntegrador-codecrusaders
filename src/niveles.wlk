import wollok.game.*
import rana.*
import objetosDeNiveles.*

object nivel {
	const niveles = [nivelUno, nivelDos]
	var nivel = 0
	
	method nivel() = nivel
	
	method aumentarNivel(){
		if(nivel <= niveles.size()){
			nivel += 1
		}
	}
	
	method nivelActual() = niveles.get(self.nivel())
	
	method siguiente(){
		const nivelSiguiente = niveles.get(self.nivel())
		nivelSiguiente.config()
	}
	
}


object nivelUno {
	
	const property autos = [ 
		new AutoBlanco(position = game.at(0,6)),
		new AutoNegro(position = game.at(20,8)),
		new AutoBlanco(position = game.at(0,10)),
		new AutoNegro(position = game.at(20,12)),
		new AutoBlanco(position = game.at(0,14))
	]
	
	const property malitos = [ 
		new Malito(position = game.at(2,16)),
		new Malito(position = game.at(9,16)),
		new Malito(position = game.at(17,16))
	]
	
	const property llegadas = [
		new Llegada(position = game.at(5,18)),
		new Llegada(position = game.at(13,18))
	]
	
	var property vidas = new Vidas()
	
	method config(){
		game.clear()
		game.addVisual(fondo)
		game.addVisualCharacter(rana) // Mueve la rana
		game.addVisual(vidas)
		rana.initialize()
		vidas.initialize()
		
		// añade los autos
		autos.forEach { auto => game.addVisual(auto) }
		
		// añade los fuegos
		malitos.forEach { malito => game.addVisual(malito) }
		
		// añade las llegadas
		llegadas.forEach { llegada => game.addVisual(llegada) }
		
		// Mueve los autos constantemente y comprueba si la rana chocó
		autos.forEach{ auto =>
			game.onTick(100, "moverAuto", {auto.desplazarse()} )
			game.onTick(1, "ranaChocada", {rana.chocada(auto)} )
		}
		
		// comprueba si la rana se quemó
		 malitos.forEach { malito =>
            game.onTick(1, "ranaQuemada", { rana.chocada(malito) })
        }
		
		// Se fija si la rana llegó a la meta
		game.onTick(1, "ranaGanadora", { rana.ganoNivel()} )
		
	}
	
}


object nivelDos {
	
	const property autos = [ 
		new AutoBlanco(position = game.at(0,6)),
		new AutoNegro(position = game.at(20,8)),
		new AutoBlanco(position = game.at(0,10)),
		new AutoNegro(position = game.at(20,12)),
		new AutoBlanco(position = game.at(0,14))
	]

	const property llegadas = [
		new Llegada(position = game.at(5,18)),
		new Llegada(position = game.at(13,18))
	]
	
	var property vidas = new Vidas()
	
	method config(){	
		game.clear()
		game.addVisual(fondo)
		game.addVisualCharacter(rana) // Mueve la rana
		game.addVisual(vidas)
		rana.initialize()
		vidas.initialize()
		
		// añade los autos
		autos.forEach { auto => game.addVisual(auto) }
		
		// añade las llegadas
		llegadas.forEach { llegada => game.addVisual(llegada) }
		
		// Mueve los autos constantemente y comprueba si la rana chocó
		autos.forEach{ auto =>
			game.onTick(100, "moverAuto", {auto.desplazarse()} )
			game.onTick(1, "ranaChocada", {rana.chocada(auto)} )
		}
		
		
		// Se fija si la rana llegó a la meta
		game.onTick(1, "ranaGanadora", { rana.ganoNivel()} )
		
	}
	
}


