#  (Plane Fight) 

UTN - Facultad Regional Buenos Aires - Materia Paradigmas de Programación

## Equipo de desarrollo: 

- Ezequiel Reichel
- Camila Nicól Ramos Fariña
- Catalina Wierna
- Gabriel Juarez
- Gonzalo Leon Bolaña
 
## Capturas 

![pepita](assets/golondrina.png)

Diagrama estatico
![pepita](assets/DiagramaEstatico(1).png)

## Reglas de Juego / Instrucciones

El juego "Plane Fight" se basa en el combate aereo del *personaje principal* contra una serie de enemigos que pueden hacerte dano de distinta manera (por ejemplo, enemigos con misiles y otros que ataquen cuerpo a cuerpo). El personaje principal posee vida (p.e 3 corazones) y los enemigos tambien tendran su correspondiente cantidad de vida, ambos objetos entienden/conocen el mensaje de perderVida pero cada uno tiene su metodo correspondiente (se aplica polimorfismo). 
La dificulatad del juego se incrementara a medida que se maten enemigos. Cada X cantidad de enemigos asesinados, su velocidad o velocidad de disparo aumentara proporcionalmente.

A su vez, tambien existiran items que podran ser soltados por los enemigos cada cierto tiempo. Puede ser un corazon, que te suma uno a la vida (maximo 3), o una estrella, la cual te proporciona invensibilidad por 5 seg. 

Al finalizar la partida (cuando el personaje principal muere) se calcula un score en base a los enemigos matados (cada enemigo tiene un puntaje distinto).

ENEMIGOS: 
-Cuerpo a Cuerpo: Genera daño cuando hay una colicion.
-Disparo a distancia: Se mantiene en el borde derecho y dipara proyectiles rectos.
-Disparo en movimiento: Se mueve por la pantalla y dispara al mismo tiempo.

BOSS: 
-Aparece luego de matar una cantidad de enemigos comunes (los mencionados previamente). Aumenta la aparicion de enemigos y a la vez tiene sus propios proyectiles. 

El objetivo del personaje es la superviviencia en contra de los enemigos que vayan aparaciendo a lo largo del juego

## Controles:

- `space` para que el personaje principal dispare proyectiles
- `V` para visualizar la vida del personaje principal
