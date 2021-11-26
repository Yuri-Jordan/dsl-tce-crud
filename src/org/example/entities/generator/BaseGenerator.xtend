package org.example.entities.generator

import org.example.entities.entities.AttributeType
import org.example.entities.entities.BasicType
import org.example.entities.entities.EntityType

class BaseGenerator {
	
	def compile(AttributeType attributeType) {
		attributeType.elementType.typeToString + if(attributeType.array) "[]" else ""
	}

	def dispatch typeToString(BasicType type) {
		if(type.typeName == "string") "String" else type.typeName
	}

	def dispatch typeToString(EntityType type) {
		type.entity.name
	}
}
