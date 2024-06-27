public with sharing class caseActivityLogController {
    @AuraEnabled(cacheable=true)
    public static List<CaseHistory> getCaseLogs(Id caseId) {
        try {
            System.debug('caseId: ' + caseId);
            System.debug('caseId: ' + [SELECT Subject FROM Case WHERE Id = :caseId LIMIT 1].Subject);
            System.debug('caseId: ' + [SELECT CaseNumber FROM Case WHERE Id = :caseId LIMIT 1].CaseNumber);
            System.debug('caseId: ' + [SELECT CreatedDate FROM Case WHERE Id = :caseId LIMIT 1].CreatedDate);
            return [
                SELECT Id, Field, OldValue, NewValue, CreatedDate
                FROM CaseHistory
                WHERE CaseId = :caseId
                ORDER BY CreatedDate DESC
            ];
        } catch (Exception e) {
            throw new AuraHandledException('Error fetching case history: ' + e.getMessage());
        }
    }
}