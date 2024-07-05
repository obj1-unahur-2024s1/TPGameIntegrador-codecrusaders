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

class Niveles{
    var property llegadas = [new Llegada(position = game.at(5,18)), new Llegada(position = game.at(13,18))]
    var property vidas = new Vidas()
    var property fondo = 0
    
    method config() {
		game.clear()
        fondos.setImage()
        game.addVisual(fondos)
  
        self.visualAdicional()

        game.addVisual(rana)
        game.addVisual(vidas)
        rana.initialize()
        vidas.initialize()
        
        // Añade los autos
        nivel.nivelActual().autos().forEach { auto => game.addVisual(auto) }
        
        // Añade las llegadas
        llegadas.forEach { llegada => game.addVisual(llegada) }
        
        // Añade los obstaculos
        nivel.nivelActual().obstaculos().forEach { obs => game.addVisual(obs) }
        
        // Mueve los autos constantemente
		nivel.nivelActual().autos().forEach{ auto =>
			game.onTick(100, "moverAuto", {auto.desplazarse()} )
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
		
		// Configurar según el nivel
        self.configurarAdicional()

    }
    
    method verificarColisionesYFilas() {
        game.whenCollideDo(rana, { x => if(x.esObstaculo()){rana.perderVida()} }) // aveces colisiona y aveces no con los autos.. 
        
        // Implementar verificaciones adicionales según el nivel
        self.verificarColisionesAdicionales()
    }
    
    method randomPosition() = (0..20).anyOne() 
    
    method configurarAdicional(){}
    
    method visualAdicional(){}
    
    method verificarColisionesAdicionales() {}
}


object nivelUnoCiudad inherits Niveles(fondo = 0){
	
	const property troncos = [
	        new TroncoDerecha(position = game.at(2,15)),
	        new TroncoDerecha(position = game.at(8,15)),
	        new TroncoDerecha(position = game.at(14,15)),
	        new TroncoDerecha2(position = game.at(3,15)),
	        new TroncoDerecha2(position = game.at(9,15)),
	        new TroncoDerecha2(position = game.at(15,15))
	]

	const property autos = [ 
			new AutoDerecha(position = game.at(self.randomPosition(),3)),
			new AutoIzquierda(position = game.at(20,4)),
			new AutoDerecha(position = game.at(self.randomPosition(),6)),
			new AutoIzquierda(position = game.at(20,7)),
			new AutoDerecha(position = game.at(self.randomPosition(),13)),
			new AutoIzquierda(position = game.at(20,12))
	]
	
	const property obstaculos = [
	        new CartelStop(position = game.at(14,2)),
	        new Valla(position = game.at(2,8)),
	        new Valla(position = game.at(3,8)),
	        new Valla(position = game.at(4,8)),
	        new Valla(position = game.at(5,8)),
	        new Valla(position = game.at(6,8)),
	        new Valla(position = game.at(7,8)),
	        new Valla(position = game.at(8,8)),
	        new Valla(position = game.at(9,8)),
	        new Valla(position = game.at(10,8)),
	        new Valla(position = game.at(11,8)),
	        new Valla(position = game.at(12,8)),
	        new Valla(position = game.at(13,8)),
	        new Valla(position = game.at(14,8)),
	        new Valla(position = game.at(15,8)),
	        new Valla(position = game.at(16,8)),
	        new Valla(position = game.at(17,8)),
	        new CartelStop(position = game.at(2,14))
	]
	
	override method visualAdicional(){
        troncos.forEach { tronco => game.addVisual(tronco) } // Añade los troncos
	}
	
	override method configurarAdicional(){
		troncos.forEach{ tronco =>
			game.onTick(300, "moverTronco", {tronco.desplazarse()}) // Mueve los troncos
		}
	}
		
	override method verificarColisionesAdicionales() {
	    rana.comprobarFila(15, troncos) // Comprobar fila de troncos
	}
	
}


object nivelDosCiudad inherits Niveles(fondo = 1){
	
	 const property nenufaresQuietos = [
    	new Nenufar(position = game.at(5,13)),
    	new Nenufar(position = game.at(11,13))
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
	    
	const property autos = [ 
			new AutoDerecha(position = game.at(0,3)),
			new AutoIzquierda(position = game.at(20,4)),
			new AutoDerecha(position = game.at(0,5)),
			new AutoIzquierda(position = game.at(20,7)),
			new AutoDerecha(position = game.at(0,8))
	]
	
	const property obstaculos = []
	
	override method visualAdicional(){
        // Añade los troncos
        troncos.forEach { tronco => game.addVisual(tronco) }
        // Añade los nenufares
        nenufaresQuietos.forEach { nenufarQuieto => game.addVisual(nenufarQuieto)}
	}
	
	override method configurarAdicional(){	
		// Mueve los troncos
		troncos.forEach{ tronco =>
			game.onTick(300, "moverTronco", {tronco.desplazarse()})
		}
	}
		
	override method verificarColisionesAdicionales() {
	    // Comprobar fila de nenúfares y troncos
	    rana.comprobarFila(15, troncos)
		rana.comprobarFila(13, nenufaresQuietos)
	    rana.comprobarFila(12, troncos)
	}
	
}


object nivelUnoDesierto inherits Niveles(fondo = 2){
	
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
	
	const property obstaculos = []
		
	override method visualAdicional(){	
		// Añade los cactus
		cactus.forEach {cacti => game.addVisual(cacti)}
	}
}



object nivelDosDesierto inherits Niveles(fondo = 3){

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
	
	const property autos = [
			new AutoDerecha(position = game.at(0,8)),
			new AutoIzquierda(position = game.at(20,9)),
			new AutoDerecha(position = game.at(0,14)),
			new AutoIzquierda(position = game.at(20,13))
	]
	
	const property obstaculos = []
		
	override method visualAdicional(){	
		// Añade los cactus
		cactus.forEach { cacti => game.addVisual(cacti)}
		
		// Añade los trenes
		trenes.forEach {tren => game.addVisual(tren)}
		
		// Añade las plantas rodadoras
		plantas.forEach {planta => game.addVisual(planta)}
	}
	
	override method configurarAdicional(){
		// Mueve los trenes y plantas
		game.onTick(100, "moverObjetos", {
			plantas.forEach{planta => planta.desplazarse()}
			trenes.forEach{tren => tren.desplazarse()}
		})
	}
	
}

