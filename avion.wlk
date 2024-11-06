
object avion {
  var property vida = 3 
  var property position = new MutablePosition(x=0,y=8)
  var property enemigosEliminados = 0
  var property puntaje = 0
  var property esEnemigo = false
  const imamgenBalaPersonaje = "spaceMissiles_015.png"

  method image() = "cuphead.png"

  method hablar() = "Bienvenidos a mi juego..." 

  method decirVida() = self.vida()

  method decirPuntos() = self.puntaje()

  method sumarPuntaje(enemigo){puntaje+=enemigo.puntaje()}
  
  method agregarCorazones(c0,c1,c2) {
    game.addVisual(c0)
	  game.addVisual(c1)
	  game.addVisual(c2) 
  }

  method perderVida() {
    vida -= 1             //Hay que aplicarle como minimo 0
    if(self.vida() == 0){
      game.removeVisual(self)
      game.addVisual(fondoFinDelJuego)
      game.addVisual(finDelJuego)
      sonidoGameOver.reproducirSonido()
    }
  }

  method disparar()  {
  const nuevaBala = new Bala(latitud=self.position().x(), altura =self.position().y() , imagen = imamgenBalaPersonaje, esEnemigo=false, id = 0.randomUpTo(5000))
  game.addVisual(nuevaBala)
	game.onTick(100,"disparo"+nuevaBala.id(),{nuevaBala.moveteDerecha()})
	game.whenCollideDo(nuevaBala, {elemento => 
	if (elemento.esEnemigo() && elemento.esBala().negate()){
  elemento.perderVida()
  nuevaBala.eliminarBala()
	}
  })
	}  
                         
}

class Corazon {
  const id
  var property esBala = false
  var property esEnemigo = false
  
  method esCuerpoACuerpo() = false
  method image() = "heart_21 (2).png"
  method position() = new MutablePosition(x=id,y=10)
  method desaparecer() =  game.removeVisual(self) 
}

object fondoFinDelJuego {

  //const posicionX = (game.width() * 100) / 2
	//const posicionY = (game.height() * 100) / 2

  //method position() = game.at(posicionX,posicionY)
  method position() = game.origin()

  method image() = "game over.png"
  
}

object paleta {
  const property rojo = "FF0000FF"
}

object finDelJuego {

  method position() = game.center()

  method text() = "Game OVER! - Puntaje obtenido: " + avion.puntaje().toString()

  method textColor() = paleta.rojo()
}

object sonidoGameOver {
  method reproducirSonido(){
    game.sound("water-drop-sound.mp3").play()
  }
}

class EnemigoCuerpoACuerpo {
  var property puntaje = 5
  method esCuerpoACuerpo() = true
  var property esBala = false
  var property position = new MutablePosition(x=19,y=0.randomUpTo(10))   // Para que arranque en alguna posicion del borde
  var property velocidad = 1000     // mientras menos velocidad, el enemigo se desplaza mas rapido
  var property vida = 5
  var property esEnemigo = true
  var property id 

  method cambiarVelocidad() {velocidad = 100.max(velocidad-50)} //Hay que pensar un minimo (pensamos 100)

  method image() = "alienQueSeMueve.png"


  method reaparecerAlaDerecha() {position = new MutablePosition(x=18,y=0.randomUpTo(10))}

  method despalzamiento(){
    game.onTick(self.velocidad(), "movimiento"+self.id(), { self.movete() })
  }

  method movete(){  // se desplaza uno para la izquierda
    position.goLeft(1)

    if(position.x() < 0) {
      self.reaparecerAlaDerecha()
    }
  }
  
    method perderVida() { 
    vida -= 1
    if(self.vida()==0) {
      avion.sumarPuntaje(self)
      fase.sacarEnemigosVivos()
      fase.sumarEliminados(self)
      game.removeTickEvent("movimiento"+self.id())
      game.removeVisual(self)
    }
  }
}

class EnemigoPistolero {
  const imagenBalaPistolero = "bala_Enemigo.png"
  method esCuerpoACuerpo() = false
  var property position = game.at(17,0.randomUpTo(10))   // Para que arranque en alguna posicion del borde
  var property vida = 3
  var property esBala = false
  var property intervaloDisparo = 2000      // mientras menos, el intervalo entre cada bala es mas rapido
  var property velocidadDisparo = 250       // mientras menos, la velocidad de las balas es mas rapida
  var property esEnemigo = true
  var property puntaje = 7
  var property id 

  
  method cambiarIntervaloDisparo() {intervaloDisparo = 1000.max(intervaloDisparo-100)} //Hay que pensar un minimo (pensamos 100)

  method cambiarVelocidadDisparo() {velocidadDisparo = 100.max(velocidadDisparo-25)}

  method image() = "alienQueDispara.png"

  method disparar(){
    
    game.onTick(self.intervaloDisparo(), "disparoEnemigo1"+self.id(), { 
      const nuevaBala = new Bala(latitud=self.position().x(), altura =self.position().y() , imagen=imagenBalaPistolero, esEnemigo=true,id = 0.randomUpTo(5000) )
      game.addVisual(nuevaBala)
      game.onTick(self.velocidadDisparo(), "disparoEnemigo2"+nuevaBala.id(), { nuevaBala.moveteIzquierda() })
    }) 
		
  }

  method perderVida() { 
    vida -= 1
    if(self.vida()==0) {
      avion.sumarPuntaje(self)
      fase.sacarEnemigosVivos()
      fase.sumarEliminados(self)
      game.removeTickEvent("disparoEnemigo1"+self.id())
      game.removeVisual(self)
    }
  }

}


class Bala {
  var property esCuerpoACuerpo = false
  var property latitud
  var property altura
  var property position = new MutablePosition(x=latitud,y=altura)
  var property imagen  
  var property esEnemigo 
  var property esBala = true
  var property id 

  method image() = imagen

  method perderVida() = true

  method vida () = 3

  method eliminarBala(){
    position = new MutablePosition(x=100,y=100)
    game.removeTickEvent("disparo"+self.id())
    game.removeVisual(self)
  }
  method moveteDerecha() {
    if(position.x() < 20) {
      position.goRight(1)
    }
    else {
      self.eliminarBala()
    }
  }

  method moveteIzquierda(){
    if(position.x() > 0) {
      position.goLeft(1)
    }
    else {
      game.removeTickEvent("disparoEnemigo2"+self.id())
      game.removeVisual(self)
    }
  }
}

object fase {
  var property tiempoAparicion = 4000 //miliseg
  var property maxEnemigos = 4 
  var property enemigosVivos = 0
  var property nroFase = 1
  var property eliminacionesCambioFase = 10
  var property enemigosEliminadosFase = 0


  method sumarEliminado() {
    enemigosEliminadosFase += 1
  }

  method reiniciarEliminados(){
    enemigosEliminadosFase = 0
  }
  
  method sumarEliminados(enemigo){
    if(nroFase == 1  && enemigo.esCuerpoACuerpo()){
      self.sumarEliminado()
    }
    else if(nroFase==2 && enemigo.esCuerpoACuerpo().negate()){
      self.sumarEliminado()
    }
    else {
      self.sumarEliminado()
    }
    
  } 
  
  method cambiarFase() { 
    if(nroFase < 3){
      nroFase += 1
      self.reiniciarEliminados()
    }
    else {
      self.cambiarTiempoAparicion()
      self.cambiarEnemigosMax()

      EnemigoCuerpoACuerpo.cambiarVelocidad()
      EnemigoPistolero.cambiarIntervaloDisparo()
      EnemigoPistolero.cambiarVelocidadDisparo()

      nroFase = 1

    }
  }

  method cambiarTiempoAparicion() {
    if(tiempoAparicion > 1000) tiempoAparicion -= 1000
  }
  
  method cambiarEnemigosMax(){
    if(maxEnemigos<12) maxEnemigos += 3
  }
  
  method agregarCuerpoACuerpo () {
    if (nroFase == 1 or nroFase==3){
    const nuevoEnemigoCuerpo = new EnemigoCuerpoACuerpo(id = 0.randomUpTo(5000))
    game.addVisual(nuevoEnemigoCuerpo)
    self.sumarEnemigosVivos()
    nuevoEnemigoCuerpo.despalzamiento()
    }

  }

  method agregarPistolero (){ //el ovni 
    if (nroFase == 2 or nroFase==3){
    const nuevoEnemigoPistolero = new EnemigoPistolero(id = 0.randomUpTo(5000))
    game.addVisual(nuevoEnemigoPistolero)
    self.sumarEnemigosVivos()
    nuevoEnemigoPistolero.disparar()
  }
  }

  method sumarEnemigosVivos() { 
    enemigosVivos += 1
  }

  method sacarEnemigosVivos() {
    enemigosVivos -= 1
  }
  
}