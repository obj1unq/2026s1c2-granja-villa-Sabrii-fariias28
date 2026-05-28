import wollok.game.*
import cultivos.*
import direcciones.*
import granja.*
import bonus.*


object personaje {
	var property position = game.center()
	const property image = "fplayer.png"
	var property totalMonedas = 0
	var property cultivoActual = maizSemilla
	var property cultivosCosechados = #{} 

	//Acciones
	// yo lo hubiera hecho con parametro, pero en clases nos dijeron que no...
	method sembrar() {   
	  self.validarParcela()
	  cultivoActual.sembrarseEn(self.position())
	}

	method cambiarSemilla(semilla) {
        cultivoActual = semilla
    }

	method regar() {
      self.validarSiSePuedeRegar()
      self.cultivoEnMiPosicion().crecer()
    }

	method cocechar() {
  	  self.validarCocecha()
      const cultivo = self.cultivoEnMiPosicion()

      if(cultivo.esCocechable()) {
    	 cultivo.cocecharse()
    	 cultivosCosechados.add(cultivo)
       }
	}

	method vender() {
		self.validarVenta()
		const mercado = granja.mercadoEn(self.position())

		if(!mercado.puedeComprar(cultivosCosechados)) {
        self.error("El mercado no tiene monedas suficientes")
        }

		mercado.comprarCultivos(cultivosCosechados)
	    totalMonedas += self.totalMonedasDeLaCocecha(cultivosCosechados)
        cultivosCosechados.clear()
	}
	
	method ponerAspersor() {
        const nuevoAspersor = new Aspersor(position = self.position())
        nuevoAspersor.colocarAspersor()
    }

	method mover(direccion){
	  position = direccion.siguiente(position)
   }

    method estado() {
  		return "Tengo " + totalMonedas + " monedas, y " + cultivosCosechados.size() + " plantas para vender"
    }

	method totalMonedasDeLaCocecha(cocechas) {
	  return cultivosCosechados.sum({ cultivo => cultivo.monedas() })
	}

    //Validaciones 
	method validarParcela() {
	  if (self.hayCultivoEnMiPosicion()) {
       self.error("No puedo sembrar. Hay cultivo acá")
      }
	}

	method cultivoEnMiPosicion() {
      return granja.cultivoEn(self.position())
	}

	method validarSiSePuedeRegar() {
      if(!self.hayCultivoEnMiPosicion()) {
        self.error("No tengo nada para regar")
      }
    }

	method validarCocecha(){
	    if(!self.hayCultivoEnMiPosicion()) {
        self.error("No tengo nada para cocechar")
      }
	}

	method validarVenta() {
	  if(!self.hayMercadoEnMiPosicion()){
		self.error("No estoy sobre un mercado para poder vender.")
	  }
	}

	// Consultas
	method hayCultivoEnMiPosicion() {
	    return granja.hayCultivoEn(self.position())
	}

	method hayMercadoEnMiPosicion() {
	  return granja.hayMercadoEn(self.position())
	}

	method esCultivo() = false
	method esMercado() = false

	//
	method crecer() {} 
}
