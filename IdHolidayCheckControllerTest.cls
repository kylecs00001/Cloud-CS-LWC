@isTest
private class IdHolidayCheckControllerTest {
    
     @isTest
    static void testIsValidIDRecordExists() {
      
        SA_ID_Number__c saIdRecord = new SA_ID_Number__c(
            ID_Number__c = 1234567,  
            Date_Of_Birth__c = Date.newInstance(1990, 1, 1), 
            Gender__c = 'Male',  
            SA_Citizen__c = true 
        );
        insert saIdRecord;

       
        Boolean result = IdHolidayCheckController.isValidID('9001015009087');
        System.assertEquals(null, result, 'isValidID = null');
    }

    @isTest
    static void testIsValidID() {
        
        SA_ID_Number__c saIdRecord = new SA_ID_Number__c(
            ID_Number__c = 1234567890,  
            Date_Of_Birth__c = Date.newInstance(1990, 1, 1), 
            Gender__c = 'Female',  
            SA_Citizen__c = true  
        );
        insert saIdRecord;

        Test.startTest();
        Boolean result = IdHolidayCheckController.isValidID('9001015009087'); 
        System.assertEquals(null, result);
        Test.stopTest();
    }

    @isTest
    static void testMakeApiCallout() {
        
        SA_ID_Number__c saIdRecord = new SA_ID_Number__c(
            ID_Number__c = 1234567890,  
            Date_Of_Birth__c = Date.newInstance(1990, 1, 1), 
            Gender__c = 'Female',  
            SA_Citizen__c = true  
        );
        insert saIdRecord;
        
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        Test.startTest();
        String result = IdHolidayCheckController.makeApiCallout('9001015009087'); 
        System.assertEquals('Test Holiday: Test Holiday Fake', result);
        Test.stopTest();
    }

   
    private class MockHttpResponseGenerator implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest request) {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setBody('{"response": {"holidays": [{"name": "Test Holiday", "description": "Test Holiday Fake"}]}}');
            return response;
        }
    }
}