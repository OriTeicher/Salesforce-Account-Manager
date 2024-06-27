public with sharing class caseActivityLogController {
    @AuraEnabled(cacheable=true)
    public static List<CaseHistory> getCaseLogs(Id caseId) {
        try {
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