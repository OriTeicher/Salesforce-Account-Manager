import { LightningElement, api, wire, track } from "lwc"
import { refreshApex } from "@salesforce/apex"
import getCaseHistory from "@salesforce/apex/CaseActivityLogController.getCaseHistory"
import { getRecordNotifyChange } from "lightning/uiRecordApi"
import { ShowToastEvent } from "lightning/platformShowToastEvent"
import { caseActivityLogsService } from "./services/case.activity.log.service.js"

export default class CaseActivityLog extends LightningElement {
   @api recordId
   @track caseHistory = []
   wiredCaseHistoryResult

   @wire(getCaseHistory, { caseId: "$recordId" })
   wiredCaseHistory(result) {
      this.wiredCaseHistoryResult = result
      if (result.data) {
         try {
            this.caseHistory = result.data.map((item) => {
               console.log("item", item)
               const date = caseActivityLogsService.fomratDate(item.CreatedDate)
               console.log("date", date)
               return {
                  id: item.Id,
                  field: item.Field,
                  oldValue: item.OldValue,
                  newValue: item.NewValue,
                  date
               }
            })
         } catch (error) {
            console.error("Error processing case history data: ", error.message)
         }
      } else if (result.error) {
         console.error("Error loading case history: ", result.error)
      }
   }

   get columns() {
      return [
         { label: "Field", fieldName: "field", type: "text" },
         { label: "Old Value", fieldName: "oldValue", type: "text" },
         { label: "New Value", fieldName: "newValue", type: "text" },
         { label: "Change Date", fieldName: "date", type: "date" }
      ]
   }

   handleRefresh() {
      refreshApex(this.wiredCaseHistoryResult)
   }

   connectedCallback() {
      this.recordChangeHandler = () => {
         this.handleRefresh()
      }
      this.template.addEventListener("recordChange", this.recordChangeHandler)
   }

   disconnectedCallback() {
      this.template.removeEventListener(
         "recordChange",
         this.recordChangeHandler
      )
   }

   renderedCallback() {
      getRecordNotifyChange([{ recordId: this.recordId }])
   }

   get hasHistory() {
      return this.caseHistory.length > 0
   }
}
