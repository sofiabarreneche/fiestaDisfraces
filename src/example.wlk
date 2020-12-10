class Fiesta{
	var lugar
	var fecha
	var invitados = #{}
	method agregarAsistente(persona)= persona.tieneDisfraz() and !invitados.contains(persona)
	method fiestaInolvidable() = invitados.all({unInvitado => unInvitado.esSexi()}) and
		invitados.all({unInvitado => unInvitado.estaConformeConDisfraz()})
	
	method esBodrio(){
		invitados.all({unInvitado => unInvitado.estaConformeConDisfraz()})
	}
	method mejorDisfraz(){
		invitados.max({unInvitado => unInvitado.disfraz().puntuacion()})
	}
	method intercambioDisfraz(persona1,persona2) = self.condicionesParaIntercambioDisfraz(persona1,persona2)
		
	method estarianConformes(p1,p2){
		const disfrazParaCambiar = p1.disfraz()
		return p1.estariaConforme(p2.disfraz()) and p2.estariaConforme(disfrazParaCambiar)
	}
	method condicionesParaIntercambioDisfraz(p1,p2) = 
		invitados.contains(p1) and invitados.contains(p2) and
		self.algunoDisconformeDisfraz(p1,p2) and self.estarianConformes(p1,p2)
	
	method algunoDisconformeDisfraz(p1,p2) = !p1.estaConformeConDisfraz() || !p2.estaConformeConDisfraz()
	
}
class Invitado{
	var disfraz
	var sexi
	var personalidad
	var edad
	var property estaConformeConDisfraz
	method tieneDisfraz() = disfraz.size() > 0
	
	method estariaConforme(disfrazNuevo){	//ESTA PARTE NO SE COMO HACER PARA QUE SE FIJE SI ESTARIA CONFORME, EN VEZ DE CAMBIARLO Y LUEGO FIJARSE
		self.cambiarDisfraz(disfrazNuevo)
		return estaConformeConDisfraz
	}
	method cambiarPersonalidad(nuevo){
		personalidad.esSexy(self)
	}
	method cambiarDisfraz(nuevo){
		disfraz = nuevo
	}
	method esSexi(){
		return sexi
	}
	method esMenor(cantidad) = edad < cantidad
	
	
}
object disfraz{
	var fechaConfeccion
	var property puntuacion
	var caracteristicas = []
	var nombre
	method cantidadLetrasPar(){
		nombre.size() % 2 == 0
	}
	method hechoHace(cant) = new Date() - fechaConfeccion < cant
	method cumpleCondicionPuntos(cant) = puntuacion == cant
}
object gracioso{
	var nivelGracia
	var antiguedad
	method sacarPuntos(invitado){
		if(antiguedad > 50){
			return nivelGracia*3
	}else return nivelGracia
	}
}
object tobara{
	var diaComprado
	method sacarPuntos(invitado){
		if(new Date() - diaComprado > 2 ){
			return 5
		}else return 3
	}
}
object mickeyMouse{
	var property puntos =8
}
object osoCarolina{
	var property puntos =6
}
object careta{
	var personaje
	method sacarPuntos(invitado){
		personaje.puntos()
	}
}
object sexies{
	
	method sacarPuntos(invitado){
		if(invitado.esSexi()){
			return 15
		}else return 2
	}
}
object alegre{
	method esSexy(persona){
		return false
	}
}
object taciturna{
	method esSexy(persona){
		return persona.esMenor(30)
	}
}
object cambiante{														//ESTE NO SE SI ESTA BIEN O NO
	var personalidadPosible = #{taciturna,alegre}
	method cambiarPersonalidad(personalidad,persona){
		if(personalidadPosible.contains(personalidad)){
			persona.cambiarPersonalidad(personalidad)
		}
	}
}
object caprichoso inherits Invitado{
	method condicion() = disfraz.cantidadLetrasPar()
	
}
object pretencioso inherits Invitado{
		method condicion() = disfraz.hechoHace(30)
}
object numerologos inherits Invitado{
	var cifra
	method condicion() = disfraz.puntuacion() > 10 and disfraz.cumpleCondicionPuntos(cifra)
}