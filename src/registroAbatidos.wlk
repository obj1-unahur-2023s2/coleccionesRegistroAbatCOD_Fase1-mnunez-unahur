object registroAbatidosCOD {
	const registro = []
	const indiceFecha = 0
	const indiceAbatidos = 1
	
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
		lista.sortBy({ x, y => x.get(indiceFecha) < y.get(indiceFecha) })
		lista.forEach({ r => self.agregarAbatidosDia(r.get(indiceAbatidos), r.get(indiceFecha))})
	}
	
	// indica si tiene registros para el día indicado
	method tieneRegistroDelDia(dia) {
		return registro.any({ r => r.get(indiceFecha) == dia })
	}

	// retorna el registro para el día especificado
	// prerequisito: debe existir un registro para el día especificado
	method registroDelDia(dia) {
		return registro.find({ r => r.get(indiceFecha) == dia })
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
		return registro.any({ r => r.get(indiceAbatidos) == cantidad})
	}
	
	// indica la cantidad del primer registro
	method primerValorDeAbatidos() {
		return registro.first().get(indiceAbatidos)
	}

	// el último valor registrado
	method ultimoValorDeAbatidos() {
		return registro.last().get(indiceAbatidos)
	}

	// Demostrar que last() == size()-1.
	//prerequisitos: el registro debe tener entradas
	method ultimoValorDeAbatidosConSize() {
		return registro.get(registro.size() - 1).get(indiceAbatidos)
	}

	// el valor más alto de abatidos incluido en el registro
	method maximoValorDeAbatidos() {
		return registro.max({ r => r.get(indiceAbatidos) }).get(indiceAbatidos)
	}
	
	// el total de abatidos por el jugador, de acuerdo a la información incluida en el registro.
	method totalAbatidos() {
		return registro.sum({ r => r.get(indiceAbatidos) })
	}
	
	// la cantidad de abatidos por el jugador el día indicado
	method cantidadDeAbatidosElDia(dia) {
		return self.registroDelDia(dia).get(indiceAbatidos)
	}
	
	// los dias que abatió un valor superior al indicado
	method diasConAbatidosSuperioresA(cuanto) {
		return registro.filter({ r => r.get(indiceAbatidos) > cuanto }).map({ r => r.get(indiceFecha) })
	}
	
	// los valores de abatidos del registro que son valores pares.
	method valoresDeAbatidosPares() {
		return registro.filter({r => r.get(indiceAbatidos).even()}).map({ r => r.get(indiceAbatidos) })
	}
	
	// encuentra y retorna el valor indicado en cantidad
	method elValorDeAbatidos(cantidad) {
		
	}
	
	// la lista de valores que resulta de sumar el valor indicado en 'cantidad' a cada valor de abatidos del registro
	method abatidosSumando(cantidad) {
		return registro.map( { r => r.get(indiceAbatidos) + cantidad})
	}
	
	//indica si en el registro, la cantidad de abatidos se encuentra entre los valores indicados
	method abatidosEsAcotada(n1, n2) {
		return registro.all({ r => r.get(indiceAbatidos).between(n1, n2)})
	}
	
	// indica si algún día de que se tiene registro, la cantidad de abatidos es mayor al valor indicado
	method algunDiaAbatioMasDe(cantidad) {
		return registro.any({ r=>r.get(indiceAbatidos) > cantidad })
	}
	
	// indica si todos los días de que se tiene registro, la cantidad de abatidos es mayor al valor indicado
	method todosLosDiasAbatioMasDe(cantidad) {
		return registro.all({ r=>r.get(indiceAbatidos) > cantidad })
	}
	
	// la cantidad de valores de abatidos diaria que superan a la cantidad indicada para el primer día del registro
	// prerequisito: deben haber entradas en el registro
	method cantidadAbatidosMayorALaPrimera() {
		return registro.count({ r => r.get(indiceAbatidos) > registro.first().get(indiceAbatidos)})
	}
	
	// indica verdadero si en todos los días de los que se tiene registro, 
	// el valor de abatidos siempre fue aumentando
	method esCrack() {
		return 	registro.size() >= 2 
				and (1..registro.size()-1).all({i => registro.get(i-1).get(indiceAbatidos) < registro.get(i).get(indiceAbatidos)})
	}
	
}