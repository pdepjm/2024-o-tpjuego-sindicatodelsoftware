object pepita {
  var energy = 100
  const position = new MutablePosition(x=0, y=0)
  //var property position = game.origin()

  method image() = "golondrina.png"
  method position() = position

  method energy() = energy

  method fly(minutes) {
    energy = energy - minutes * 3
    position.goRight(minutes)
    position.goUp(minutes)
  }

}

object avion {
  var property position = game.center() 

  method image() = "Biplane (1).png"

  method hablar() = "Bienvenidos a mi juego..." 
}

object enemigo {
  var property position = game.at(19,0.randomUpTo(10))   // Para que arranque en alguna posicion del borde

  method image() = "ufo_game_enemy.png"

  method movete(){  // se desplaza uno para la izquierda
    position = position.left(1)
  }
}