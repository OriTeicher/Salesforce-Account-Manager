public class caseCommentsBatch implements Database.Batchable<SObject>, Database.Stateful {
    private Id caseId;
    private Integer commentsAmount;
    private Integer commentsCreatedCounter;


    public caseCommentsBatch(Id caseId, Integer amount) {
        this.caseId = caseId;
        this.commentsAmount = amount;
        this.commentsCreatedCounter = 0;
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id FROM Case WHERE Id = :caseId]);
    }

    public void execute(Database.BatchableContext bc, List<Case> scope) {
        List<CaseComment> commentsToCreate = new List<CaseComment>();

        for (Integer i = 0; i < 200 && commentsCreatedCounter < commentsAmount; i++) {
            CaseComment comment = new CaseComment(
                ParentId = caseId,
                CommentBody = 'Comment number #' + commentsCreatedCounter,
                IsPublished = true
            );
            commentsToCreate.add(comment);
            commentsCreatedCounter++;
        }

        if (!commentsToCreate.isEmpty()) {
            insert commentsToCreate;
        } else {
            System.debug('there are no comments');
        }
    }

    public void finish(Database.BatchableContext bc) {
        if (commentsCreatedCounter < commentsAmount) {
            caseCommentsBatch nextBatch = new caseCommentsBatch(caseId, commentsAmount - commentsCreatedCounter);
            Database.executeBatch(nextBatch, 200);
            System.debug('remaining comments: ' + commentsAmount - commentsCreatedCounter);
        } else {
            System.debug(commentsCreatedCounter + ' comments created succesfully');
        }
    }
}
