export const caseActivityLogsService = {
  getCaseEntity,
}

const EMPTY_VALUE = "-----"

function getCaseEntity(activityLog) {
  return {
    id: activityLog.Id,
    field: activityLog.Field,
    oldValue: activityLog.OldValue || EMPTY_VALUE,
    newValue: activityLog.NewValue || EMPTY_VALUE,
    date: _formatDate(activityLog.CreatedDate),
  }
}

function _formatDate(isoString) {
  const date = new Date(isoString)
  const options = {
    day: "2-digit",
    month: "2-digit",
    year: "numeric",
    hour: "2-digit",
    minute: "2-digit",
    hour12: false,
  }
  return new Intl.DateTimeFormat("he-IL", options)
    .format(date)
    .replace(",", " |")
}
