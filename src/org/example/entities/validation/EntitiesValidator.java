/*
 * generated by Xtext 2.25.0
 */
package org.example.entities.validation;

import java.util.HashSet;

import org.eclipse.xtext.validation.Check;
import org.example.entities.entities.Entity;
import org.example.entities.entities.EntitiesPackage;


/**
 * This class contains custom validation rules.
 *
 * See
 * https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#validation
 */
public class EntitiesValidator extends AbstractEntitiesValidator {

	@Check
	 public void checkNoCycleInEntityHierarchy(Entity entity) {
		
		if (entity.getSuperType() == null) return; // nothing to check
				
		var visitedEntities = new HashSet<Entity>();
		visitedEntities.add(entity);
		
		var current = entity.getSuperType();
		
		while (current != null) {
			 if (visitedEntities.contains(current)) {
				 error("cycle in hierarchy of entity '" + current.getName() + "'" , 
						 EntitiesPackage.eINSTANCE.getEntity_SuperType());
				 return;
			 }
			 visitedEntities.add(current);
			 current = current.getSuperType();
		 }

	}

}
