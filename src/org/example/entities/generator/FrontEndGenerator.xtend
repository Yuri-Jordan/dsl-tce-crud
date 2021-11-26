package org.example.entities.generator

import org.example.entities.entities.Entity
import org.eclipse.xtext.generator.IFileSystemAccess2

class FrontEndGenerator extends BaseGenerator {

	val String[] tiposArquivos = #["list", "form"]
	IFileSystemAccess2 _fsa;

	def compile(IFileSystemAccess2 fsa, Entity entity) {

		this._fsa = fsa;

		tiposArquivos.forEach [ element, index |

			gerarArquivos(entity, element)
		]

	}

	def gerarArquivos(Entity entity, String tipoArquivo) {

		switch (tipoArquivo) {
			case "list": {
				val diretorio = "frontEnd/" + entity.name + "-";
				this._fsa.generateFile(diretorio + tipoArquivo + ".component.html", gerarArquivoListagem(entity));
			}
			case "form": {
				val diretorio = "frontEnd/" + entity.name + "-";
				this._fsa.generateFile(diretorio + tipoArquivo + ".component.ts", gerarArquivoForm(entity));
			}
			default: {
			}
		}
	}

	def gerarArquivoForm(Entity entity) {
		'''
			"Form"
		'''
	}

	def gerarArquivoListagem(Entity entity) {
		'''
			"List"
		'''
	}
}
