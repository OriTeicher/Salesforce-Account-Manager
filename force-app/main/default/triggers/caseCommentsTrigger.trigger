trigger caseCommentsTrigger on Case (after insert) {
    for (Case newCase : Trigger.new) {
        caseCommentsBatch batch = new caseCommentsBatch(newCase.Id, 20000);
        Database.executeBatch(batch, 200); 
    }
}