public class caseCommentsBatch implements Database.Batchable<SObject>, Database.Stateful {
    private Id caseId;
    private final Integer COMMENTS_TO_CREATE_AMOUNT;
    private final Integer BATCH_SIZE;
    private Integer commentsCreatedCounter;

    public caseCommentsBatch(Id caseId, Integer amount, Integer batchSize) {
        this.caseId = caseId;
        this.COMMENTS_TO_CREATE_AMOUNT = amount;
        this.BATCH_SIZE = batchSize;
        this.commentsCreatedCounter = 0;
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id FROM Case WHERE Id = :caseId]);
    }

    public void execute(Database.BatchableContext bc, List<Case> scope) {
        List<CaseComment> commentsToCreate = new List<CaseComment>();

        for (Integer i = 0; i < BATCH_SIZE && commentsCreatedCounter < COMMENTS_TO_CREATE_AMOUNT; i++) {
            CaseComment comment = new CaseComment(
                ParentId = caseId,
                CommentBody = 'Comment #' + (commentsCreatedCounter + 1),
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
        if (commentsCreatedCounter < COMMENTS_TO_CREATE_AMOUNT) {
            caseCommentsBatch nextBatch = new caseCommentsBatch(caseId, COMMENTS_TO_CREATE_AMOUNT, BATCH_SIZE);
            nextBatch.commentsCreatedCounter = this.commentsCreatedCounter;
            Database.executeBatch(nextBatch, BATCH_SIZE);
            System.debug('Remaining comments: ' + (COMMENTS_TO_CREATE_AMOUNT - commentsCreatedCounter));
        } else {
            System.debug(COMMENTS_TO_CREATE_AMOUNT + ' comments created successfully.');
        }
    }
}
