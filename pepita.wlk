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