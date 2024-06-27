import { LightningElement, api, wire, track } from "lwc"
import getCaseLogs from "@salesforce/apex/CaseActivityLogController.getCaseLogs"
import { caseActivityLogsService } from "./services/case.activity.log.service.js"
import { registerRefreshHandler,unregisterRefreshHandler } from "lightning/refresh"
import { refreshApex } from "@salesforce/apex"

export default class CaseActivityLog extends LightningElement {
   @api recordId
   @track caseLogs = []
   wiredCaseLogs
   refreshLogsId

   connectedCallback() {
      this.refreshLogsId = registerRefreshHandler(this, this.refreshLogs)
   }

  disconnectedCallback() {
    unregisterRefreshHandler(this.refreshLogsId)
    this.refreshLogsId = null
   }

   @wire(getCaseLogs, { caseId: "$recordId" })
   wiredCaseHistory(result) {
      this.wiredCaseLogs = result
      if (result.data) {
         try {
            this.caseLogs = result.data.map((log) => caseActivityLogsService.getCaseEntity(log))
         } catch (error) {
            console.error(error.message)
         }
      } else if(result.error){
        console.error(error)
      }
   }

   async refreshLogs() {
      try {
         await refreshApex(this.wiredCaseLogs)
      } catch (error) {
         console.error(error.message)
      }
   }

   get columnsFields() {
      return [
         { label: "Field", fieldName: "field", type: "text" },
         { label: "Old Value", fieldName: "oldValue", type: "text" },
         { label: "New Value", fieldName: "newValue", type: "text" },
         { label: "Change date", fieldName: "date", type: "text" }
      ]
   }

   get isLogsEmpty() {
      return this.caseLogs.length < 0
   }

}
