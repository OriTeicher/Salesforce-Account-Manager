trigger caseCommentsTrigger on Case (after insert) {
    final Integer COMMENTS_TO_CREATE_AMOUNT = 1000;
    final Integer BATCH_SIZE = 100;

    for (Case newCase : Trigger.new) {
        caseCommentsBatch batch = new caseCommentsBatch(newCase.Id, COMMENTS_TO_CREATE_AMOUNT, BATCH_SIZE);
        Database.executeBatch(batch, BATCH_SIZE); 
    }
}
