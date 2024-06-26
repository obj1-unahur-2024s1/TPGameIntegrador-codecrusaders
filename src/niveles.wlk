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
		new AutoDerecha(position = game.at(0,3)),
		new AutoIzquierda(position = game.at(20,4)),
		new AutoDerecha(position = game.at(0,6)),
		new AutoIzquierda(position = game.at(20,7)),
		new AutoDerecha(position = game.at(0,13)),
		new AutoIzquierda(position = game.at(0,12))
	]
	
	const property llegadas = [
		new Llegada(position = game.at(5,18)),
		new Llegada(position = game.at(13,18))
	]
	
	const property obstaculos = [
        new CartelStop(position = game.at(14,2)),
        new Valla(position = game.at(3,8)),
        new Valla(position = game.at(4,8)),
        new Valla(position = game.at(5,8)),
        new Valla(position = game.at(6,8)),
        new Valla(position = game.at(10,8)),
        new Valla(position = game.at(11,8)),
        new Valla(position = game.at(12,8)),
        new Valla(position = game.at(13,8))
        
    ]
    
    const property nenufares = [
        new Nenufar(position = game.at(2,15)),
        new Nenufar(position = game.at(8,15)),
        new Nenufar(position = game.at(13,15)),
        new Nenufar(position = game.at(3,15)),
        new Nenufar(position = game.at(9,15)),
        new Nenufar(position = game.at(14,15))
    ]
	
	var property vidas = new Vidas()
	
	const property fondo = 0
	
	method config(){
		game.clear()
		fondos.setImage()
		game.addVisual(fondos)
		
		// añade los nenúfares
        nenufares.forEach { nenufar => game.addVisual(nenufar) }
        
		game.addVisual(rana)
		game.addVisual(vidas)
		rana.initialize()
		vidas.initialize()
		
		// añade los autos
		autos.forEach { auto => game.addVisual(auto) }
		
		// añade las llegadas
		llegadas.forEach { llegada => game.addVisual(llegada) }
		
		 // añade los obstaculos
        obstaculos.forEach { obs => game.addVisual(obs) }
        
		// Mueve los autos constantemente y comprueba si la rana chocó
		autos.forEach{ auto =>
			game.onTick(100, "moverAuto", {auto.desplazarse()} )
			game.onTick(1, "ranaChocada", {rana.chocada(auto)} )
		}
		
		nenufares.forEach{ nenufar =>
			game.onTick(500, "moveNenufar", {nenufar.desplazarse()})
		}
        
        // comprueba si la rana chocó con un obstaculo
        obstaculos.forEach { obstaculo =>
            game.onTick(1, "ranaChocadaConObstaculo", { rana.chocadaConObstaculo(obstaculo) })
        }
        
        // comprueba si la rana está en una fila específica sin estar sobre un nenúfar
        game.onTick(1, "comprobarFilaNenufares", { rana.comprobarFilaNenufares(15, nenufares) })
		
		// Configuración del teclado para mover la rana
		keyboard.up().onPressDo{rana.moverArriba()}
		keyboard.down().onPressDo{rana.moverAbajo()}
		keyboard.left().onPressDo{rana.moverIzquierda()}
		keyboard.right().onPressDo{rana.moverDerecha()}
			
	}
	
}


object nivelDosCiudad {
	
	const property autos = [ 
		new AutoDerecha(position = game.at(0,6)),
		new AutoIzquierda(position = game.at(20,8)),
		new AutoDerecha(position = game.at(0,10)),
		new AutoIzquierda(position = game.at(20,12)),
		new AutoDerecha(position = game.at(0,14))
	]

	const property llegadas = [
		new Llegada(position = game.at(5,18)),
		new Llegada(position = game.at(13,18))
	]
	
	var property vidas = new Vidas()
	
	const property fondo = 1
	
	method config(){	
		game.clear()
		fondos.setImage()
		game.addVisual(fondos)
		game.addVisual(rana) 
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
		
		// Configuración del teclado para mover la rana
		keyboard.up().onPressDo{rana.moverArriba()}
		keyboard.down().onPressDo{rana.moverAbajo()}
		keyboard.left().onPressDo{rana.moverIzquierda()}
		keyboard.right().onPressDo{rana.moverDerecha()}
	}
	
}


object nivelUnoDesierto {
	
	const property autos = [ 
		new AutoDerecha(position = game.at(0,6)),
		new AutoIzquierda(position = game.at(20,8)),
		new AutoDerecha(position = game.at(0,10)),
		new AutoIzquierda(position = game.at(20,12)),
		new AutoDerecha(position = game.at(0,14))
	]

	const property llegadas = [
		new Llegada(position = game.at(5,18)),
		new Llegada(position = game.at(13,18))
	]
	
	var property vidas = new Vidas()
	
	const property planta = new PlantaRodadora(position = game.at(20, 2))
	
	const property fondo = 2
	
	method config(){	
		game.clear()
		fondos.setImage()
		game.addVisual(fondos)
		game.addVisual(rana) // Mueve la rana
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
		
		// Configuración del teclado para mover la rana
		keyboard.up().onPressDo{rana.moverArriba()}
		keyboard.down().onPressDo{rana.moverAbajo()}
		keyboard.left().onPressDo{rana.moverIzquierda()}
		keyboard.right().onPressDo{rana.moverDerecha()}
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
	
	const property fondo = 3
	
	method config(){	
		game.clear()
		fondos.setImage()
		game.addVisual(fondos)
		game.addVisual(rana) // Mueve la rana
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
		
		// Configuración del teclado para mover la rana
		keyboard.up().onPressDo{rana.moverArriba()}
		keyboard.down().onPressDo{rana.moverAbajo()}
		keyboard.left().onPressDo{rana.moverIzquierda()}
		keyboard.right().onPressDo{rana.moverDerecha()}
	}
	
}

