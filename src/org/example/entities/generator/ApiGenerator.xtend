package org.example.entities.generator

import org.example.entities.entities.Entity
import org.eclipse.xtext.generator.IFileSystemAccess2

class ApiGenerator extends BaseGenerator {

	val String[] tiposArquivos = #["Controller", "Service", "Model", "Dto"]

	def compile(IFileSystemAccess2 fsa, Entity entity) {

		tiposArquivos.forEach [ element, index |

			fsa.generateFile("api/" + entity.name + element + ".cs", gerarArquivos(entity, element))
		]

	}

	def gerarArquivos(Entity entity, String tipoArquivo) {

		switch (tipoArquivo) {
			case "Controller": {
				gerarArquivoController(entity);
			}
			case "Service": {
				gerarArquivoService(entity);
			}
			case "Model": {
				gerarArquivoModel(entity);
			}
			case "Dto": {
				gerarArquivoModelDto(entity);
			}
			default: {
			}
		}
	}

	def gerarArquivoModel(Entity entity) {
		'''
			package entities;
			
			public class «entity.name» «IF entity.superType !== null»extends «entity.superType.name» «ENDIF»{
				«FOR attribute : entity.attributes»
					private «attribute.type.compile» «attribute.name»;
				«ENDFOR»
				«FOR attribute : entity.attributes»
					public «attribute.type.compile» get«attribute.name.toFirstUpper»() {
						return «attribute.name»;
					}
					
					public void set«attribute.name.toFirstUpper»(«attribute.type.compile» _arg) {
						this.«attribute.name» = _arg;
					}
					
				«ENDFOR»
			}
		'''
	}

	def gerarArquivoController(Entity entity) {
		'''
			"Controller"
		'''
	}

	def gerarArquivoModelDto(Entity entity) {
		'''
			"DTO"
		'''
	}

	def gerarArquivoService(Entity entity) {
		'''
			"Service"
		'''
	}
}
