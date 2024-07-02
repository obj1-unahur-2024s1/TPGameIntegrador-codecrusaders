import wollok.game.*
import rana.*
import objetosDeNiveles.*
import sonidos.*

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
        new Valla(position = game.at(2,8)),
        new Valla(position = game.at(3,8)),
        new Valla(position = game.at(4,8)),
        new Valla(position = game.at(5,8)),
        new Valla(position = game.at(6,8)),
        new Valla(position = game.at(7,8)),
        new Valla(position = game.at(10,8)),
        new Valla(position = game.at(11,8)),
        new Valla(position = game.at(12,8)),
        new Valla(position = game.at(13,8)),
        new Valla(position = game.at(15,8)),
        new Valla(position = game.at(16,8)),
        new Valla(position = game.at(17,8)),
        new CartelStop(position = game.at(2,14))
    ]
    
    const property troncos = [
        new TroncoDerecha(position = game.at(2,15)),
        new TroncoDerecha(position = game.at(8,15)),
        new TroncoDerecha(position = game.at(14,15)),
        new TroncoDerecha2(position = game.at(3,15)),
        new TroncoDerecha2(position = game.at(9,15)),
        new TroncoDerecha2(position = game.at(15,15))
    ]

	var property vidas = new Vidas()
	
	const property fondo = 0
	
	method config(){
		game.clear()
		fondos.setImage()
		game.addVisual(fondos)
		
		// Añade los troncos
        troncos.forEach { tronco => game.addVisual(tronco) }
		
		game.addVisual(rana)
		game.addVisual(vidas)
		rana.initialize()
		vidas.initialize()
		
		// Añade los autos
		autos.forEach { auto => game.addVisual(auto) }
		
		// Añade las llegadas
		llegadas.forEach { llegada => game.addVisual(llegada) }
		
		 // Añade los obstaculos
        obstaculos.forEach { obs => game.addVisual(obs) }
        
		// Mueve los autos constantemente
		autos.forEach{ auto =>
			game.onTick(100, "moverAuto", {auto.desplazarse()} )
		}
		
		// Mueve los troncos
		troncos.forEach{ tronco =>
			game.onTick(300, "moverTronco", {tronco.desplazarse()})
		}
        
        // Comprueba si le ocurre algo a la rana
        game.onTick(50, "comprobarColisiones", {
        	self.verificarColisionesYFilas()
    	})
    	
		// Configuración del teclado para mover la rana
		keyboard.up().onPressDo{moverArriba.mover()}
		keyboard.down().onPressDo{moverAbajo.mover()}
		keyboard.left().onPressDo{moverIzquierda.mover()}
		keyboard.right().onPressDo{moverDerecha.mover()}
			
		}
		
		method verificarColisionesYFilas() {
	    	const filaRana = rana.position().x() // Obtiene la posición X de la rana para determinar la fila
	    
	   		 // Verificar colisiones con autos en la misma fila
	    	autos.filter { auto => auto.position().x() == filaRana }.forEach { auto => rana.chocada(auto) }
	    	
	    	// Comprobar fila de nenúfares
	    	rana.comprobarFilaNenufares(15, troncos)
		}
	
}


object nivelDosCiudad {
	
	const property autos = [ 
		new AutoDerecha(position = game.at(0,3)),
		new AutoIzquierda(position = game.at(20,4)),
		new AutoDerecha(position = game.at(0,5)),
		new AutoIzquierda(position = game.at(20,7)),
		new AutoDerecha(position = game.at(0,8))
	]

	const property llegadas = [
		new Llegada(position = game.at(5,18)),
		new Llegada(position = game.at(13,18))
	]
	
	const property troncos = [
        new TroncoDerecha(position = game.at(2,15)),
        new TroncoDerecha(position = game.at(8,15)),
        new TroncoDerecha(position = game.at(14,15)),
        new TroncoDerecha2(position = game.at(3,15)),
        new TroncoDerecha2(position = game.at(9,15)),
        new TroncoDerecha2(position = game.at(15,15)),
        
        new TroncoIzquierda(position = game.at(2,12)),
        new TroncoIzquierda(position = game.at(9,12)),
        new TroncoIzquierda2(position = game.at(3,12)),
        new TroncoIzquierda2(position = game.at(10,12))
    ]
    
    const property nenufaresQuietos = [
    	new Nenufar(position = game.at(5,13)),
    	new Nenufar(position = game.at(11,13))
    ]
    
    const property obstaculos = []
	
	var property vidas = new Vidas()
	
	const property fondo = 1
	
	method config(){	
		game.clear()
		fondos.setImage()
		game.addVisual(fondos)
		
		// Añade los troncos
        troncos.forEach { tronco => game.addVisual(tronco) }
        // Añade los nenufares
        nenufaresQuietos.forEach { nenufarQuieto => game.addVisual(nenufarQuieto)}
		
		game.addVisual(rana) 
		game.addVisual(vidas)
		rana.initialize()
		vidas.initialize()
		
		// Añade los autos
		autos.forEach { auto => game.addVisual(auto) }
				
		// Añade las llegadas
		llegadas.forEach { llegada => game.addVisual(llegada) }
        
		// Mueve los autos constantemente
		autos.forEach{ auto =>
			game.onTick(100, "moverAuto", {auto.desplazarse()} )
		}
		
		// Mueve los troncos
		troncos.forEach{ tronco =>
			game.onTick(300, "moverTronco", {tronco.desplazarse()})
		}
        
        // Comprueba si le ocurre algo a la rana
        game.onTick(50, "comprobarColisiones", {
        	self.verificarColisionesYFilas()
    	})
    	
		// Configuración del teclado para mover la rana
		keyboard.up().onPressDo{moverArriba.mover()}
		keyboard.down().onPressDo{moverAbajo.mover()}
		keyboard.left().onPressDo{moverIzquierda.mover()}
		keyboard.right().onPressDo{moverDerecha.mover()}
		}
		
		method verificarColisionesYFilas() {
	    	const filaRana = rana.position().x() // Obtiene la posición X de la rana para determinar la fila
	    
	   			// Verificar colisiones con autos en la misma fila
	    		autos.filter { auto => auto.position().x() == filaRana }.forEach { auto => rana.chocada(auto) }
	    
	    		// Comprobar fila de nenúfares y troncos
	    		rana.comprobarFilaNenufares(15, troncos)
		    	rana.comprobarFilaNenufares(13, nenufaresQuietos)
	    		rana.comprobarFilaNenufares(12, troncos)
		}
	
}


object nivelUnoDesierto {
	
	const property autos = [ 
		new AutoDerecha(position = game.at(0,3)),
		new AutoIzquierda(position = game.at(20,4)),
		new AutoDerecha(position = game.at(0,10)),
		new AutoIzquierda(position = game.at(20,11)),
		new AutoIzquierda(position = game.at(0,9)),
		new AutoDerecha(position = game.at(0,8)),
		new AutoIzquierda(position = game.at(20,15)),
		new AutoDerecha(position = game.at(0,16))
	]

	const property llegadas = [
		new Llegada(position = game.at(5,18)),
		new Llegada(position = game.at(13,18))
	]
	
	var property vidas = new Vidas()
	
	const property cactus = [ 
		new Cactus(position = game.at(2,6)),
		new Cactus(position = game.at(9,6)),
		new Cactus(position = game.at(17,6)),
		new Cactus(position = game.at(0,14)),
		new Cactus(position = game.at(13,14)),
		new Cactus(position = game.at(18,14)),
		new Cactus(position = game.at(7,12)),
		new Cactus(position = game.at(3,12)),
		new Cactus(position = game.at(14,12))
	]
	
	const property obstaculos = []
	
	const property fondo = 2
	
	method config(){	
		game.clear()
		fondos.setImage()
		game.addVisual(fondos)
		game.addVisual(rana)
		game.addVisual(vidas)
		rana.initialize()
		vidas.initialize()
		
		// Añade los cactus
		cactus.forEach {cacti => game.addVisual(cacti)}
		
		// Añade los autos
		autos.forEach { auto => game.addVisual(auto) }
				
		// Añade las llegadas
		llegadas.forEach { llegada => game.addVisual(llegada) }
        
		// Mueve los autos y plantas
		game.onTick(100, "moverObjetos", {
			autos.forEach{auto => auto.desplazarse()}
		})
        
        // Comprueba si le ocurre algo a la rana
        game.onTick(50, "comprobarColisiones", {
        	self.verificarColisionesYFilas()
    	})
    	
		// Configuración del teclado para mover la rana
		keyboard.up().onPressDo{moverArriba.mover()}
		keyboard.down().onPressDo{moverAbajo.mover()}
		keyboard.left().onPressDo{moverIzquierda.mover()}
		keyboard.right().onPressDo{moverDerecha.mover()}
			
		}
		
		method verificarColisionesYFilas() {
	    	
	    	const filaRana = rana.position().x() // Obtiene la posición X de la rana para determinar la fila
	    	
	   			// Verificar colisiones en la misma fila
	    		autos.filter { auto => auto.position().x() == filaRana }.forEach { auto => rana.chocada(auto) }
	     		cactus.filter { cacti => cacti.position().x() == filaRana }.forEach { cacti => rana.chocada(cacti)}    

		}

}



object nivelDosDesierto {
	
	const property autos = [
		new AutoDerecha(position = game.at(0,8)),
		new AutoIzquierda(position = game.at(20,9)),
		new AutoDerecha(position = game.at(0,14)),
		new AutoIzquierda(position = game.at(20,13))
	]
	
	const property trenes = [
		new Locomotora(position = game.at(0,3)),
		new Vagon(position = game.at(-1,3)),
		new Vagon(position = game.at(-2,3)),
		new Vagon(position = game.at(-1,3)),
		new Vagon(position = game.at(-3,3)),
		new Vagon(position = game.at(-4,3)),
		new Vagon(position = game.at(-5,3)),
		new Vagon(position = game.at(-6,3)),
		new Vagon(position = game.at(-7,3)),
		new Vagon(position = game.at(-8,3)),
		new Locomotora(position = game.at(0,16)),
		new Vagon(position = game.at(-1,16)),
		new Vagon(position = game.at(-2,16)),
		new Vagon(position = game.at(-3,16)),
		new Vagon(position = game.at(-4,16)),
		new Vagon(position = game.at(-5,16)),
		new Vagon(position = game.at(-6,16)),
		new Vagon(position = game.at(-7,16)),
		new Vagon(position = game.at(-8,16))
	]

	const property llegadas = [
		new Llegada(position = game.at(5,18)),
		new Llegada(position = game.at(13,18))
	]
	
	const property cactus = [ 
		new Cactus(position = game.at(2,6)),
		new Cactus(position = game.at(9,6)),
		new Cactus(position = game.at(17,6)),
		new Cactus(position = game.at(0,10)),
		new Cactus(position = game.at(13,10)),
		new Cactus(position = game.at(18,10)),
		new Cactus(position = game.at(7,12)),
		new Cactus(position = game.at(3,12)),
		new Cactus(position = game.at(14,12))
	]
	
	const property plantas = [
		new PlantaRodadora(position = game.at(20, 5)),
		new PlantaRodadora(position = game.at(20, 11))
	]
	
	const property obstaculos = []
	
	var property vidas = new Vidas()
	
	const property fondo = 3
	
	method config(){	
		game.clear()
		fondos.setImage()
		game.addVisual(fondos)
		game.addVisual(rana)
		game.addVisual(vidas)
		rana.initialize()
		vidas.initialize()
		
		
		// Añade los cactus
		cactus.forEach { cacti => game.addVisual(cacti)}
		
		// Añade los trenes
		trenes.forEach {tren => game.addVisual(tren)}
		
		// Añade las plantas rodadoras
		plantas.forEach {planta => game.addVisual(planta)}
		
		// Añade los autos
		autos.forEach { auto => game.addVisual(auto) }
				
		// Añade las llegadas
		llegadas.forEach { llegada => game.addVisual(llegada) }
        
		// Mueve los autos, los trenes y plantas
		game.onTick(100, "moverObjetos", {
			autos.forEach{auto => auto.desplazarse()}
			plantas.forEach{planta => planta.desplazarse()}
			trenes.forEach{tren => tren.desplazarse()}
		})
        
        // Comprueba si le ocurre algo a la rana
        game.onTick(50, "comprobarColisiones", {
        	self.verificarColisionesYFilas()
    	})
    	
		// Configuración del teclado para mover la rana
		keyboard.up().onPressDo{moverArriba.mover()}
		keyboard.down().onPressDo{moverAbajo.mover()}
		keyboard.left().onPressDo{moverIzquierda.mover()}
		keyboard.right().onPressDo{moverDerecha.mover()}
			
		}
		
		method verificarColisionesYFilas() {
	    	const filaRana = rana.position().x() // Obtiene la posición X de la rana para determinar la fila
	    	
	   			// Verificar colisiones en la misma fila
	    		autos.filter { auto => auto.position().x() == filaRana }.forEach { auto => rana.chocada(auto) }
	    		plantas.filter{ planta => planta.position().x() == filaRana }.forEach { planta => rana.chocada(planta)}
	    		trenes.filter { tren => tren.position().x() == filaRana }.forEach { tren => rana.chocada(tren)}
	    		cactus.filter { cacti => cacti.position().x() == filaRana }.forEach { cacti => rana.chocada(cacti)}    
   
		}

}

