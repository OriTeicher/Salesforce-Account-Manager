trigger caseCommentsTrigger on Case (after insert) {
    final Integer CASE_COMMENTS_AMOUNT = 30;
    final Integer BATCH_SIZE = 5;

    for (Case newCase : Trigger.new) {
        caseCommentsBatch batch = new caseCommentsBatch(newCase.Id, CASE_COMMENTS_AMOUNT, BATCH_SIZE);
        Database.executeBatch(batch, BATCH_SIZE); 
    }
}