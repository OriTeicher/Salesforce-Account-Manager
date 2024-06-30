trigger caseCommentsTrigger on Case (after insert) {
    final Integer CASE_COMMENTS_AMOUNT = 20000;
    final Integer BATCH_SIZE = 200;

    for (Case newCase : Trigger.new) {
        caseCommentsBatch batch = new caseCommentsBatch(newCase.Id, CASE_COMMENTS_AMOUNT, BATCH_SIZE);
        Database.executeBatch(batch, BATCH_SIZE); 
    }
}
