import cultivos.*
import wollok.game.*


class Aspersor {
    var property position

    method image(){
        return  "aspersor.png"
    } 

    method colocarAspersor() {
        game.addVisual(self)
        self.iniciarRiego()
    } 

    method iniciarRiego() {
        game.onTick(1000, "regar " + position.x().toString() + " " + position.y().toString() , { self.regarAlrededor() })
    }

    method regarAlrededor() {
        const parcelasVecinas = [
            position.up(1), 
            position.down(1), 
            position.left(1), 
            position.right(1)
        ]
        parcelasVecinas.forEach({ parcela => game.getObjectsIn(parcela).forEach({ parcela => parcela.crecer() })})
    }

    method esMercado() = false

    method esCosechable() = false

    method esCultivo() = false

    method crecer() {} 
}

class Mercado {
    var property position
    var property monedas 
    var property mercaderia = []

    method image() {
        return "market.png"
    }

    method puedeComprar(cultivos) {
        return monedas >= cultivos.sum({ cultivo => cultivo.monedas() })
    }

    method comprarCultivos(cultivos) {
        const precio = cultivos.sum({ cultivo => cultivo.monedas() })
        monedas -= precio
        mercaderia.addAll(cultivos)
    }

    method esCosechable() = false

    method esCultivo() = false

    method esMercado() = false

    method crecer() {}
}