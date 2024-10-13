
object avion {
  var property vida = 3 
  var property position = new MutablePosition(x=0,y=8)
  var property enemigosEliminados = 0
  var property puntaje = 0
  const imamgenBalaPersonaje = "spaceMissiles_015.png"

  method image() = "cuphead.png"

  method hablar() = "Bienvenidos a mi juego..." 

  method decirVida() = self.vida()

  method decirPuntos() = self.puntaje()

  method sumarPuntaje(enemigo){puntaje+=enemigo.puntaje()}

  method perderVida() {
    vida -= 1             //Hay que aplicarle como minimo 0

    if(self.vida() == 0){
      game.removeVisual(self)
      game.addVisual(finDelJuego)
    }
  }

  method disparar()  {
  const nuevaBala = new Bala(position=self.position() , imagen = imamgenBalaPersonaje, esEnemigo=false)
  game.addVisual(nuevaBala)
	game.onTick(100,"disparo",{nuevaBala.moveteDerecha()})
	game.whenCollideDo(nuevaBala, {elemento => 
	nuevaBala.quitarVida(elemento)
	if (elemento.esEnemigo() && elemento.esBala().negate()){ //Esto lo podemos hacer en un metodo de la bala directamente
	game.removeVisual(nuevaBala)
	}})
	}  
                         
}

object finDelJuego {

  method position() = game.center()

  method text() = "¡Game Over!"
}



class EnemigoCuarpoACuerpo {
  var property puntaje = 5
  method esCuarpoACuerpo() = true
  var property esBala = false
  var property position = game.at(19,0.randomUpTo(10))   // Para que arranque en alguna posicion del borde
  var property velocidad = 1000
  var property vida = 5
  var property esEnemigo = true

  method cambiarVelocidad() {velocidad -= 100} //Hay que pensar un minimo

  method image() = "alienQueSeMueve.png"


  method reaparecerAlaDerecha() {position = game.at(18,0.randomUpTo(10))}

  method despalzamiento(){
    game.onTick(self.velocidad(), "movimiento", { 
    if (self.vida()>0) {
    self.movete() 
    }
    })
  }

  method movete(){  // se desplaza uno para la izquierda
    position = position.left(1)

    if(position.x() < 0) {
      self.reaparecerAlaDerecha()
    }

  }
  
    method perderVida() { 
    
      vida -= 1
  
    if(self.vida()==0) {
      vida -= 1
      avion.sumarPuntaje(self)
      fase.sacarEnemigosVivos()
      fase.sumarEliminados(self)
      game.removeVisual(self)
    }
  }
  
}

class EnemigoPistolero {
  const imagenBalaPistolero = "bala_Enemigo.png"
  method esCuarpoACuerpo() = false
  var property position = game.at(17,0.randomUpTo(10))   // Para que arranque en alguna posicion del borde
  var property vida = 3
  var property esBala = false
  var property intervaloDisparo = 1500
  var property velocidadDisparo = 250 
  var property esEnemigo = true
  var property puedeDisparar = true
  var property puntaje = 7
  
  method cambiarIntervaloDisparo() {intervaloDisparo -= 100} //Hay que pensar un minimo

  method cambiarVelocidadDisparo() {velocidadDisparo -=25}

  method image() = "alienQueDispara.png"

  method noPuedeDisparar(){puedeDisparar=false} 

  method disparar(){
    
    game.onTick(self.intervaloDisparo(), "disparoEnemigo", { 
      if (self.vida()>0) {
      const nuevaBala = new Bala(position=self.position(), imagen=imagenBalaPistolero, esEnemigo=true)
      game.addVisual(nuevaBala)
      game.onTick(self.velocidadDisparo(), "disparoEnemigo", { nuevaBala.moveteIzquierda() })
      }
	}) 
		
  }

  method perderVida() { 
    vida -= 1
  
    if(self.vida()==0) {
      vida -= 1
      avion.sumarPuntaje(self)
      fase.sacarEnemigosVivos()
      fase.sumarEliminados(self)
      game.removeVisual(self)
    }
  }

}


class Bala {
  var property esCuarpoACuerpo = false
  var property position 
  var property imagen  
  var property esEnemigo 
  var property esBala = true

  method image() = imagen

  method quitarVida(elemento)=elemento.perderVida()

  method perderVida() = true

  method vida () = 3

  method moveteDerecha() {
    position = position.right(1)
    if(position.x() > 20) {
      game.removeVisual(self)
    }
  }

  method moveteIzquierda(){
    position = position.left(1)
    if(position.x() < 0) {
      game.removeVisual(self)
    }
  }
}

object fase {
  var property tiempoAparicion = 4000
  var property maxEnemigos = 6  
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
    if(nroFase == 1  && enemigo.esCuarpoACuerpo()){
      self.sumarEliminado()
    }
    else if(nroFase==2 && enemigo.esCuarpoACuerpo().negate()){
      self.sumarEliminado()
    }
    else {
      self.sumarEliminado()
    }
    
  } 
  
  method cambiarFase() { 
    if(nroFase < 4){
      nroFase += 1
      self.reiniciarEliminados()
    }
    else {
      //TODO cambiar el tiempo de aparicion
      //TODO cambiar el nro max de enemigos
      //TODO cambiar velocidad de disparo y movimiento de los enemigos
      nroFase = 1
    }
  }

  method cambiarTiempoAparicion() {
    if(tiempoAparicion > 1000) tiempoAparicion -= 100
    }
  
  method cambiarEnemigosMax(){
    if(maxEnemigos<15) maxEnemigos += 3
  }
  
  method agregarCuerpoACuerpo () {
    if (nroFase == 1 or nroFase==3){
    const nuevoEnemigoCuerpo = new EnemigoCuarpoACuerpo()
    game.addVisual(nuevoEnemigoCuerpo)
    self.sumarEnemigosVivos()
    nuevoEnemigoCuerpo.despalzamiento()
    }
  }

  method agregarPistolero (){
    if (nroFase == 2 or nroFase==3){
    const nuevoEnemigoPistolero = new EnemigoPistolero()
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