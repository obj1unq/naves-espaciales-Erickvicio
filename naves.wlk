class Nave {

	var property velocidad = 0
	const restriccionDeVelocidad = 300000 

	method recibirAmenaza() {}

	method propulsar(){
		if(velocidad + 20000 > restriccionDeVelocidad){
			velocidad = restriccionDeVelocidad
		}else 
			velocidad += 20000
	}

	method prepararParaViajar() {
		if(velocidad + 15000 > restriccionDeVelocidad){
			velocidad = restriccionDeVelocidad
		}else 
			velocidad += 15000
	}

	method encontrarseEnemigo() {
		self.recibirAmenaza()
		self.propulsar()
	} 
}


class NaveDeCarga inherits Nave{

	var property carga = 0

	method sobrecargada() = carga > 100000

	method excedidaDeVelocidad() = velocidad > 100000

	override method recibirAmenaza() {
		carga = 0
	}

}

class NaveDeCarga_ResiduosRadioactivos inherits NaveDeCarga{

	var property sellado = false 

	override method recibirAmenaza() {
		velocidad = 0			
	}

	method sellarAlVacio() {
		sellado = true
	}

	override method prepararParaViajar() {
		super()
		self.sellarAlVacio()
	}
}

class NaveDePasajeros inherits Nave{

	var property alarma = false
	const cantidadDePasajeros = 0

	method tripulacion() = cantidadDePasajeros + 4

	method velocidadMaximaLegal() = 300000 / self.tripulacion() - if (cantidadDePasajeros > 100) 200 else 0

	method estaEnPeligro() = velocidad > self.velocidadMaximaLegal() or alarma

	override method recibirAmenaza() {
		alarma = true
	}

}

class NaveDeCombate inherits Nave{
	
	var property modo = reposo
	const property mensajesEmitidos = []

	method emitirMensaje(mensaje) {
		mensajesEmitidos.add(mensaje)
	}
	
	method ultimoMensaje() = mensajesEmitidos.last()

	method estaInvisible() = velocidad < 10000 and modo.invisible()

	override method recibirAmenaza() {
		modo.recibirAmenaza(self)
	}

	override method prepararParaViajar(){
		super()
		if(modo != reposo){
		self.emitirMensaje("Volviendo a la base")
		}else
			self.emitirMensaje("Saliendo en misión")
	}

}

object reposo {

	method invisible() = false

	method recibirAmenaza(nave) {
		nave.emitirMensaje("¡RETIRADA!")
	}

}

object ataque {

	method invisible() = true

	method recibirAmenaza(nave) {
		nave.emitirMensaje("Enemigo encontrado")
	}

}
