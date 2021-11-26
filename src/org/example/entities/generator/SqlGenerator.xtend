package org.example.entities.generator

import org.example.entities.entities.Entity
import org.eclipse.xtext.generator.IFileSystemAccess2

class SqlGenerator extends BaseGenerator {

	def compile(IFileSystemAccess2 fsa, Entity entity) {
		fsa.generateFile("database/" + entity.name + ".sql", compileSchema(fsa, entity))
	}

	def compileSchema(IFileSystemAccess2 fsa, Entity entity) {
		'''
			IF NOT  EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[«entity.name»]')) 
			BEGIN
			
				CREATE TABLE [dbo].[«entity.name»](
				[Id«entity.name»] [int] IDENTITY(1,1) NOT NULL,
				«IF entity.superType !== null»
					[Id«entity.superType.name»] [int] NOT NULL, 
				«ENDIF»
				«FOR attribute : entity.attributes»
					[«attribute.type.compile» «attribute.name»] [varchar],
				«ENDFOR»
				CONSTRAINT [PK_«entity.name»] PRIMARY KEY CLUSTERED 
				(
					[Id«entity.name»] ASC
				))
				
				«IF entity.superType !== null»
					ALTER TABLE [dbo].[«entity.name»] ADD CONSTRAINT [FK_«entity.name»_«entity.superType.name»]
					FOREIGN KEY ([Id«entity.superType.name»]) REFERENCES [dbo].[«entity.superType.name»] ([Id«entity.superType.name»]) ON DELETE No Action ON UPDATE No Action 
				«ENDIF»
			END
		'''
	}
}
