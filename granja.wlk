import cultivos.*

object granja {
    const property  cultivos = []
    const property mercados =  []

    method agregarCultivo(cultivo) {
      cultivos.add(cultivo)
    }

    method quitarCultivo(cultivo) {
      cultivos.remove(cultivo)
    }

    method hayCultivoEn(posicion) {
      return cultivos.any { cultivo => cultivo.position() == posicion}
    }

    method cultivoEn(posicion) {
      return cultivos.find { cultivo => cultivo.position() == posicion}
    }

    method tieneCultivo(tipoCultivo) {
      // return cultivos.any({cultivo => cultivo.isKindOf(tipoCultivo)})   // Se supone que .isKindOf(...) pregunta si es de la misma clase que la dada...Pero no me andaba
       return cultivos.contains(tipoCultivo)
    }

    method agregarMercado(mercado) {
        mercados.add(mercado)
    }

    method hayMercadoEn(posicion) {
        return mercados.any { mercado => mercado.position() == posicion }
    }

    method mercadoEn(posicion) {
        return mercados.find{ mercado => mercado.position() == posicion }
    }
}