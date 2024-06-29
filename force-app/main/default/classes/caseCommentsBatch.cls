public class caseCommentsBatch implements Database.Batchable<SObject>, Database.Stateful {
    private Id caseId;
    private final Integer COMMENTS_AMOUNT;
    private final Integer BATCH_SIZE;
    private Integer commentsCreatedCounter;

    public caseCommentsBatch(Id caseId, Integer amount, Integer batchSize) {
        this.caseId = caseId;
        this.COMMENTS_AMOUNT = amount;
        this.BATCH_SIZE = batchSize;
        this.commentsCreatedCounter = 0;
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id FROM Case WHERE Id = :caseId]);
    }

    public void execute(Database.BatchableContext bc, List<Case> scope) {
        List<CaseComment> commentsToCreate = new List<CaseComment>();

        for (Integer i = 0; i < BATCH_SIZE && commentsCreatedCounter < COMMENTS_AMOUNT; i++) {
            CaseComment comment = new CaseComment(
                ParentId = caseId,
                CommentBody = 'Comment number #' + this.commentsCreatedCounter,
                IsPublished = true
            );
            commentsToCreate.add(comment);
            commentsCreatedCounter++;
        }

        if (!commentsToCreate.isEmpty()) {
            insert commentsToCreate;
        } else {
            System.debug('There are no comments to create.');
        }
    }

    public void finish(Database.BatchableContext bc) {
        if (commentsCreatedCounter < COMMENTS_AMOUNT) {
            caseCommentsBatch nextBatch = new caseCommentsBatch(caseId, COMMENTS_AMOUNT - commentsCreatedCounter,BATCH_SIZE);
            Database.executeBatch(nextBatch, BATCH_SIZE);
            System.debug('Batch executed. Remaining comments: ' + (COMMENTS_AMOUNT - this.commentsCreatedCounter));
        } else {
            System.debug(this.commentsCreatedCounter + ' comments created successfully.');
        }
    }
}
