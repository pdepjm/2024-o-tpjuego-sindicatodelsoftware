object pepita {
  var energy = 100
  const position = new MutablePosition(x=0, y=0)
  //var property position = game.origin()

  method image() = "golondrina.png"
  method position() = position

  method esEnemigo() = false
  method energy() = energy

  method fly(minutes) {
    energy = energy - minutes * 3
    position.goRight(minutes)
    position.goUp(minutes)
  }

}

object avion {
  var property vida = 3 
  
  var property position = new MutablePosition(x=0,y=8)
  

  method image() = "Biplane (1).png"

  method hablar() = "Bienvenidos a mi juego..." 

  method decirVida() = self.vida()

  method perderVida() {vida -= 1} 

}

object enemigo {
  var property position = game.at(19,0.randomUpTo(10))   // Para que arranque en alguna posicion del borde

  method image() = "ufo_game_enemy.png"

  method esEnemigo () = true

  method movete(){  // se desplaza uno para la izquierda
    position = position.left(1)
  }
}

class Bala {
  var property position 

  method esEnemigo() = false

  method image() = "spaceMissiles_015"

  method moveteDerecha() {
    position = position.right(2)
  }

  method moveteIzquierda(){
    position = position.left(2)
  }
}