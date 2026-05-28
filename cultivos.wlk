import wollok.game.*
import granja.*

class Maiz {
	var property position
	var property estadoMaiz = maizSemilla

	method image() {
		return estadoMaiz.image()
	}

	method crecer() {
	  estadoMaiz = maizMaduro
	}

	method esCultivo() = true

	method sembrarse() {
        game.addVisual(self)
		granja.agregarCultivo(self)
    }

	method cocecharse() {
		if(self.esCocechable()){
		    game.removeVisual(self)
            granja.quitarCultivo(self)
		}
	}

	method esCocechable() {
	  return estadoMaiz.puedeCocecharse()
	}

	method monedas() = 150

	method esMercado() = false
}

object maizSemilla{
	method image() {
		return "corn_baby.png"
    }

	method sembrarseEn(posicion) {
		new Maiz( position = posicion).sembrarse()
    }

	method puedeCocecharse() = false
}

object maizMaduro {
	method image() {
		return "corn_adult.png"
    }

	method puedeCocecharse() = true
}

class Trigo {
	var property position
	var property estadoTrigo = trigoBebe

	method image() {
		return estadoTrigo.image()
	}

	method crecer() {
	  estadoTrigo = estadoTrigo.siguienteEstado()
	}

	method esCultivo() = true

	method sembrarse() {
        game.addVisual(self)
		granja.agregarCultivo(self)
    }

	method cocecharse() {
	  if(self.esCocechable()){
		game.removeVisual(self)
		granja.quitarCultivo(self)
	  }
	}

	method esCocechable() {
	  return estadoTrigo.puedeCocecharse()
	}

	method monedas() {
		return estadoTrigo.monedas()
	}

	method esMercado() = false
}

object trigoBebe {
	method image() {
		return "wheat_0.png"
	}

	method sembrarseEn(posicion) {
    	new Trigo( position = posicion).sembrarse()
    }

	method siguienteEstado() {
		return trigoEvolucion1
    }

	method puedeCocecharse() = false

	method monedas() = 0
}

object trigoEvolucion1{
	method image() {
		return "wheat_1.png"
    }

    method siguienteEstado() {
		return trigoEvolucion2
    }

    method puedeCocecharse() = false

	method monedas() = 0
}

object trigoEvolucion2 {
	method image() {
		return "wheat_2.png"
    }

    method siguienteEstado() {
		return trigoEvolucion3
    }

    method puedeCocecharse() = true

	method monedas() = 100
}

object trigoEvolucion3 {
	method image() {
		return "wheat_3.png"
    }

    method siguienteEstado() {
		return trigoBebe
    }

    method puedeCocecharse() = true

	method monedas() = 200
}

class Tomato {
	var property position
	var property estadoTomato = tomatoAdulto

	method image() {
		return estadoTomato.image()
	}

	method crecer() {
	  self.moverHaciaArriba()
	}

	method moverHaciaArriba() {
		if(position.y() == 0) {
          position = game.at( position.x(),game.height() - 1)
        } else {
          position = game.at(position.x(),position.y() - 1)
        }
    }

	method esCultivo() = true

	method sembrarse() {
        game.addVisual(self)
		granja.agregarCultivo(self)
    }

	method cocecharse() {
		if(self.esCocechable()){
		  game.removeVisual(self)
		  granja.quitarCultivo(self)	
		}
	}

	method esCocechable() {
	  return estadoTomato.puedeCocecharse()
	}

	method monedas() = 80

	method esMercado() = false
}

object tomatoAdulto {
	method image() {
		return "tomaco.png"
    }

    method sembrarseEn(posicion) {
    	new Tomato(position = posicion).sembrarse()
    }

    method puedeCocecharse() = true
}


/*Pensé que tambien lo pedia por el asset 
object tomatoBebe {
  method image() {
	return "tomaco_baby.png"
  }

  method puedeCocecharse() = false
}
*/