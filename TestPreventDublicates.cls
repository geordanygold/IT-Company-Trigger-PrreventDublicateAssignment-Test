@isTest
public class TestPreventDublicates {
    
    @isTest 
    public static void preventDublics(){

    	Boolean result = FALSE;

        Client__c firstClient = ITCompanyDataFactory.oneClient(false, 'Client11');
        insert firstClient;
        
        Project__c firstProject = ITCompanyDataFactory.oneProject(false, 'Project1', firstClient.Id, true, true);
        insert firstProject;

        Developer__c firstDev = ITCompanyDataFactory.oneDev(false, 'Developer1', 1);
        insert firstDev;
        
        Project_Assignment__c firstProjAssign = ITCompanyDataFactory.oneProjAssign(false, 'ProjAssign1', firstProject.Id, firstDev.Id);
        insert firstProjAssign;

        try{

        	Project_Assignment__c secondProjAssign = ITCompanyDataFactory.oneProjAssign(false, 'ProjAssign1', firstProject.Id, firstDev.Id);
        	insert secondProjAssign;

        } catch (DmlException e){

        	result = TRUE;
        }
        
        System.assert(result);   
    }

}