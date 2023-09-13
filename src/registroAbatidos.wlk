object registroAbatidosCOD {
	const registro = []
	
	// agrega la cantidad de abatidos para un día. Si ya hay registro para el día indicado
	method agregarAbatidosDia(cantidad, dia) {
		if( self.tieneRegistroDelDia(dia) ) {
			self.error("Ya existe registro para el día indicado")
		}
		registro.add([dia, cantidad])
	}
	
	// agrega la lista de cantidades de abatidos para varios días, ordenada desde el más antiguo
	// parametros:
	//	lista: es una lista con el formato [[fecha, cantidad], [fecha, cantidad], ...]
	method agregarAbatidosVariosDias(lista) {
		lista.sortBy({ x, y => x.get(0) < y.get(0) })
		lista.forEach({ r => self.agregarAbatidosDia(r.get(1), r.get(0))})
	}
	
	// indica si tiene registros para el día indicado
	method tieneRegistroDelDia(dia) {
		return registro.any({ r => r.get(0) == dia })
	}

	// retorna el registro para el día especificado
	// prerequisito: debe existir un registro para el día especificado
	method registroDelDia(dia) {
		return registro.find({ r => r.get(0) == dia })
	}
	
	// elimina del registro el día especificado
	method eliminarElRegistroDelDia(dia) {
		registro.remove(self.registroDelDia(dia))
	}
	
	
	// elimina las cantidades de abatidos de varios días
	method eliminarLosRegistrosDeDias(dias) {
		dias.forEach({ dia => self.eliminarElRegistroDelDia(dia)})
		
	}
	
	// indica la cantidad de días de los que se tiene registro
	method cantidadDeDiasRegistrados() {
		return registro.size()
	}

	// indica si el registro está vacío o no
	method estaVacioElRegistro() {
		return registro.size() == 0
	}
	
	// indica si el registro incluye al menos un día en el que se abatió, exactamente, la cantidad indicada
	method algunDiaAbatio(cantidad) {
		return registro.any({ r => r.get(1) == cantidad})
	}
	
	// indica la cantidad del primer registro
	method primerValorDeAbatidos() {
		return registro.first().get(1)
	}

	// el último valor registrado
	method ultimoValorDeAbatidos() {
		return registro.last().get(1)
	}

	// Demostrar que last() == size()-1.
	//prerequisitos: el registro debe tener entradas
	method ultimoValorDeAbatidosConSize() {
		return registro.get(registro.size() - 1).get(1)
	}

	// el valor más alto de abatidos incluido en el registro
	method maximoValorDeAbatidos() {
		return registro.max({ r => r.get(1) }).get(1)
	}
	
	// el total de abatidos por el jugador, de acuerdo a la información incluida en el registro.
	method totalAbatidos() {
		return registro.sum({ r => r.get(1) })
	}
	
	// la cantidad de abatidos por el jugador el día indicado
	method cantidadDeAbatidosElDia(dia) {
		return self.registroDelDia(dia).get(1)
	}
	
	// los dias que abatió un valor superior al indicado
	method diasConAbatidosSuperioresA(cuanto) {
		return registro.filter({ r => r.get(1) > cuanto }).map({ r => r.get(0) })
	}
	
	// los valores de abatidos del registro que son valores pares.
	method valoresDeAbatidosPares() {
		return registro.filter({r => r.get(1).even()}).map({ r => r.get(1) })
	}
	
	// encuentra y retorna el valor indicado en cantidad
	method elValorDeAbatidos(cantidad) {
		
	}
	
	// la lista de valores que resulta de sumar el valor indicado en 'cantidad' a cada valor de abatidos del registro
	method abatidosSumando(cantidad) {
		return registro.map( { r => r.get(1) + cantidad})
	}
	
	//indica si en el registro, la cantidad de abatidos se encuentra entre los valores indicados
	method abatidosEsAcotada(n1, n2) {
		return registro.all({ r => r.get(1).between(n1, n2)})
	}
	
	// indica si algún día de que se tiene registro, la cantidad de abatidos es mayor al valor indicado
	method algunDiaAbatioMasDe(cantidad) {
		return registro.any({ r=>r.get(1) > cantidad })
	}
	
	// indica si todos los días de que se tiene registro, la cantidad de abatidos es mayor al valor indicado
	method todosLosDiasAbatioMasDe(cantidad) {
		return registro.all({ r=>r.get(1) > cantidad })
	}
	
	// la cantidad de valores de abatidos diaria que superan a la cantidad indicada para el primer día del registro
	// prerequisito: deben haber entradas en el registro
	method cantidadAbatidosMayorALaPrimera() {
		return registro.count({ r => r.get(1) > registro.get(0).get(1)})
	}
	
	// indica verdadero si en todos los días de los que se tiene registro, 
	// el valor de abatidos siempre fue aumentando
	// prerequisito:
	// 	* deben haber al menos dos registros
	method esCrack() {
//		return (1..registro.size()).all({r => r.get(r-1) < r.get(r)})
	}
	
}