trigger NotDublicProjesAssignments on Project_Assignment__c (before insert, before update) {


	SET <Id> projesIdsNew = new SET <Id>();
	SET <Id> projesIdsOld = new SET <Id>();
	SET <Id> devsIdsNew = new SET <Id>();
	SET <Id> devsIdsOld = new SET <Id>();
	
		For( Project_Assignment__c prAssnew : Trigger.new ){

			projesIdsNew.add(prAssnew.Project__c);
			devsIdsNew.add(prAssnew.Developer__c);
		}


		For( Project_Assignment__c prAss : [Select Id, Project__c, Developer__c
											From Project_Assignment__c
											Where Project__c In : projesIdsNew
											AND Developer__c In : devsIdsNew]){


			projesIdsOld.add(prAss.Project__c);
			devsIdsOld.add(prAss.Developer__c);
		}

		For( Project_Assignment__c prAssnew : Trigger.new ){

			if( projesIdsOld.contains(prAssnew.Project__c) && devsIdsOld.contains(prAssnew.Developer__c)){

				prAssnew.Developer__c.addError('This developer has already Project Assignmet witn this Project');
			}
		}
	

}