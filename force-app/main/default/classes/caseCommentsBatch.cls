public class caseCommentsBatch implements Database.Batchable<SObject>, Database.Stateful {
    private Id caseId;
    private final Integer COMMENTS_TO_CREATE_AMOUNT;
    private final Integer BATCH_SIZE;
    private Integer createdCommentsCounter;

    public caseCommentsBatch(Id caseId, Integer amount, Integer batchSize) {
        this.caseId = caseId;
        this.COMMENTS_TO_CREATE_AMOUNT = amount;
        this.BATCH_SIZE = batchSize;
        this.createdCommentsCounter = 0;
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id FROM Case WHERE Id = :caseId]);
    }

    public void execute(Database.BatchableContext bc, List<Case> scope) {
        List<CaseComment> caseComments = getCaseComments();
        if (!caseComments.isEmpty()) {
            insert caseComments;
        } else {
            System.debug('There are no comments to Insert.'); 
        }
    }

    private List<CaseComment> getCaseComments() {
        List<CaseComment> createdCaseComments = new List<CaseComment>();
        for (Integer i = 0; i < BATCH_SIZE && createdCommentsCounter < COMMENTS_TO_CREATE_AMOUNT; i++) {
            createdCaseComments.add(createComment());
            createdCommentsCounter++;
        }
        return createdCaseComments;
    }

    private CaseComment createComment() {
        return new CaseComment(
            ParentId = caseId,
            CommentBody = 'Comment number #' + (commentsCreatedCounter + 1),
            IsPublished = true
        );
    }

    public void finish(Database.BatchableContext bc) {
        if (createdCommentsCounter < COMMENTS_TO_CREATE_AMOUNT) {
            caseCommentsBatch nextBatch = new caseCommentsBatch(caseId, COMMENTS_TO_CREATE_AMOUNT, BATCH_SIZE);
            nextBatch.createdCommentsCounter = this.createdCommentsCounter;
            Database.executeBatch(nextBatch, BATCH_SIZE);
            System.debug('Remaining comments: ' + (COMMENTS_TO_CREATE_AMOUNT - createdCommentsCounter));
        } else {
            System.debug(COMMENTS_TO_CREATE_AMOUNT + ' comments created successfully.');
        }
    }
}
