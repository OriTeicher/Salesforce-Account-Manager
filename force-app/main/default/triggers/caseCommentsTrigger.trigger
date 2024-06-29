trigger caseCommentsTrigger on Case (after insert) {
    final Integer COMMENTS_AMOUNT = 100;
    final Integer BATCH_SIZE = 10;

    for (Case newCase : Trigger.new) {
        caseCommentsBatch batch = new caseCommentsBatch(newCase.Id, COMMENTS_AMOUNT, BATCH_SIZE);
        Database.executeBatch(batch, BATCH_SIZE); 
    }
}
