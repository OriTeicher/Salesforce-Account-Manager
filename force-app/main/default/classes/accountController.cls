public class accountController {
    
    @AuraEnabled(cacheable=true)
    public static Account getAccountDetails(Id accountId) {
        return [SELECT Id, Phone, Type, Description FROM Account WHERE Id = :accountId LIMIT 1];
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getUnassociatedContacts() {
        return [SELECT Id, Name, Email, MobilePhone FROM Contact WHERE AccountId = NULL LIMIT 10];
    }
    
    @AuraEnabled
    public static void updateAccountInfo(Id accountId, String phone, String type, String description, Id contactId) {
        Account acc = [SELECT Id, Phone, Type, Description FROM Account WHERE Id = :accountId LIMIT 1];
        acc.Phone = phone;
        acc.Type = type;
        acc.Description = description;
        update acc;
        
        if (contactId != null) {
            Contact contact = [SELECT Id, AccountId FROM Contact WHERE Id = :contactId LIMIT 1];
            contact.AccountId = accountId;
            System.debug(contact);
            update contact;
        } else {
            System.debug('contact id not found');
        }
    }
    
}
