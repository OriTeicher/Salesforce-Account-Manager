trigger caseTrigger on Case (after update) {
    List<CaseUpdateEvent__e> events = new List<CaseUpdateEvent__e>();
    for (Case c : Trigger.new) {
        CaseUpdateEvent__e event = new CaseUpdateEvent__e(
            CaseId__c = c.Id
        );
        events.add(event);
    }
    EventBus.publish(events);
}