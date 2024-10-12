
object avion {
  var property vida = 3 
  
  var property position = new MutablePosition(x=0,y=8)

  var property enemigosEliminados = 0

  method image() = "cuphead.png"

  method hablar() = "Bienvenidos a mi juego..." 

  method decirVida() = self.vida()

  method perderVida() {
    vida -= 1             //Hay que aplicarle como minimo 0

    if(self.vida() == 0){
      //game.removeVisual(self)
      game.addVisual(finDelJuego)
    }

    }                             
}

object finDelJuego {

  method position() = game.center()

  method text() = "¡Game Over!"
}



object enemigoCuarpoACuerpo {

  var property esCuarpoACuerpo = true 

  var property esBala = false

  var property position = game.at(19,0.randomUpTo(10))   // Para que arranque en alguna posicion del borde

  var property velocidad = 1000

  var property vida = 5

  method cambiarVelocidad() {velocidad -= 100} //Hay que pensar un minimo

  method image() = "alienQueSeMueve.png"

  var property esEnemigo = true

  method reaparecerAlaDerecha() {position = game.at(19,0.randomUpTo(10))}

  method movete(){  // se desplaza uno para la izquierda
    position = position.left(1)

    if(position.x() < 0) {
      self.reaparecerAlaDerecha()
    }

  }
  
  method perderVida() {vida -= 1}
  
}

object enemigoPistolero {

  var property esCuarpoACuerpo = false
  
  var property position = game.at(18,0.randomUpTo(10))   // Para que arranque en alguna posicion del borde

  var property vida = 3

  var property esBala = false

  var property intervaloDisparo = 900

  var property velocidadDisparo = 250 

  method cambiarIntervaloDisparo() {intervaloDisparo -= 100} //Hay que pensar un minimo

  method cambiarVelocidadDisparo() {velocidadDisparo -=25}

  method image() = "alienQueDispara.png"

  var property esEnemigo = true

  var property puedeDisparar = true

  method noPuedeDisparar(){puedeDisparar=false} 

  method perderVida() { 
    vida -= 1 
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
    position = position.right(2)
  }

  method moveteIzquierda(){
    position = position.left(2)
  }
}