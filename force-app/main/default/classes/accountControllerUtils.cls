public class accountControllerUtils {
    public static void getRandomUnassociatedContacts(Integer amount) {
        List<Contact> contacts = new List<Contact>();
        List<String> firstNames = new List<String>{'Liam', 'Noah', 'Ethan', 'Aiden', 'Logan', 'Lucas', 'Mason', 'Oliver', 'Elijah', 'James', 'William', 'Benjamin', 'Alexander', 'Jacob', 'Michael', 'Daniel', 'Henry', 'Matthew', 'Samuel', 'Sebastian'};
            List<String> lastNames = new List<String>{'Smith', 'Johnson', 'Williams', 'Brown', 'Jones', 'Garcia', 'Miller', 'Davis', 'Martinez', 'Hernandez', 'Lopez', 'Gonzalez', 'Wilson', 'Anderson', 'Thomas', 'Taylor', 'Moore', 'Jackson', 'Martin', 'Lee'};
                
                for (Integer i = 0; i < amount; i++) {
                    Integer randomFirstNamesIdx = Math.mod(Math.abs(Crypto.getRandomInteger()), firstNames.size());
                    Integer randomLastNamesIdx = Math.mod(Math.abs(Crypto.getRandomInteger()), lastNames.size());
                    String randomMobile = '05' + String.valueOf(Math.round(Math.random() * 10000000)).rightPad(8, '0');
                    
                    Contact contactToSave = new Contact(
                        FirstName = firstNames[randomFirstNamesIdx],
                        LastName = lastNames[randomLastNamesIdx],
                        Email = firstNames[randomFirstNamesIdx].toLowerCase() + '.' + lastNames[randomLastNamesIdx].toLowerCase() + '.' + String.valueOf(i) + '@example.com',
                        MobilePhone = randomMobile
                    );
                    contacts.add(contactToSave);
                }
        
        insert contacts;
    }
    
    public static void deleteAllContacts() {
        List<Contact> contactsToDelete = [SELECT Id FROM Contact];
        if (!contactsToDelete.isEmpty()) {
            Database.delete(contactsToDelete, false);
            System.debug('Deleted ' + contactsToDelete.size() + ' contacts.');
        } else {
            System.debug('No contacts found to delete.');
        }
    }
}