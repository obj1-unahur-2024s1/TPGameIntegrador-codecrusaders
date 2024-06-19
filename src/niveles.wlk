import wollok.game.*
import rana.*
import objetosDeNiveles.*

object nivel {
	const niveles = []
	var nivel = 0
	
	method nivel() = nivel
	
	method aumentarNivel(){
		if(nivel == 0){
			nivel += 1
			self.siguiente()
		} else{ game.stop() }
	}
	
	method nivelActual() = niveles.get(self.nivel())
	
	method siguiente(){
		const nivelSiguiente = niveles.get(self.nivel())
		nivelSiguiente.config()

	}
	
	method configurarEscenarioDesierto(){
		niveles.add(nivelUnoDesierto)
		niveles.add(nivelDosDesierto)
	}
	
	method configurarEscenarioCiudad(){
		niveles.add(nivelUnoCiudad)
		niveles.add(nivelDosCiudad)
	}
	
}


object nivelUnoCiudad {
	
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
	
	const property fondo = "fondo1.png"
	
	method config(){
		game.clear()
		game.addVisual(fondos)
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


object nivelDosCiudad {
	
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
	
	const property fondo = "fondo1.png"
	
	method config(){	
		game.clear()
		game.addVisual(fondos)
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


object nivelUnoDesierto {
	
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
	
	const property planta = new PlantaRodadora(position = game.at(20, 2))
	
	const property fondo = "fondo2.png"
	
	method config(){	
		game.clear()
		game.addVisual(fondos)
		game.addVisualCharacter(rana) // Mueve la rana
		game.addVisual(vidas)
		rana.initialize()
		vidas.initialize()
		game.addVisual(planta)
		game.onTick(100, "moverPlanta", {planta.desplazarse()})
		
		// añade los autos
		autos.forEach { auto => game.addVisual(auto) }
		
		// añade las llegadas
		llegadas.forEach { llegada => game.addVisual(llegada) }
		
		// Mueve los autos constantemente y comprueba si la rana chocó
		autos.forEach{ auto =>
			game.onTick(100, "moverAuto", {auto.desplazarse()} )
			game.onTick(1, "ranaChocada", {rana.chocada(auto)} )
			game.onTick(1, "ranaChocada", {rana.chocada(planta)} )
		}
		
		
		// Se fija si la rana llegó a la meta
		game.onTick(1, "ranaGanadora", { rana.ganoNivel()} )
		
	}
	
}



object nivelDosDesierto {
	
	const property tren = [
		new Locomotora(position = game.at(20,13)),
		new Vagon(position = game.at(21,13)),
		new Vagon(position = game.at(22,13))
	]

	const property llegadas = [
		new Llegada(position = game.at(5,18)),
		new Llegada(position = game.at(13,18))
	]
	
	const property cactus = [ 
		new Cactus(position = game.at(2,16)),
		new Cactus(position = game.at(9,16)),
		new Cactus(position = game.at(17,16))
	]
	
	var property vidas = new Vidas()
	
	const property fondo = "fondo2.png"
	
	method config(){	
		game.clear()
		game.addVisual(fondos)
		game.addVisualCharacter(rana) // Mueve la rana
		game.addVisual(vidas)
		rana.initialize()
		vidas.initialize()
		
		tren.forEach {trn => game.addVisual(trn)}
			tren.forEach {trn =>
			game.onTick(100, "moverTren", {trn.desplazarse()})
		}
		
		// añade las llegadas
		llegadas.forEach { llegada => game.addVisual(llegada) }
		
		// Mueve los autos constantemente y comprueba si la rana chocó
		tren.forEach{ trn =>
			game.onTick(1, "ranaChocada", {rana.chocada(trn)} )
		}
		
		// comprueba si la rana se pinchó
		// añade los cactus
		cactus.forEach { c => game.addVisual(c) }
		 cactus.forEach { c =>
            game.onTick(1, "ranaPinchada", { rana.chocada(c) })
        }
		
		// Se fija si la rana llegó a la meta
		game.onTick(1, "ranaGanadora", { rana.ganoNivel()} )
		
	}
	
}

