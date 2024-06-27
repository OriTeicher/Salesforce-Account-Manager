import { LightningElement, api, wire, track } from "lwc"
import getCaseLogs from "@salesforce/apex/CaseActivityLogController.getCaseLogs"
import { caseActivityLogsService } from "./caseActivityLogService.js"
import {
   registerRefreshHandler,
   unregisterRefreshHandler
} from "lightning/refresh"
import { refreshApex } from "@salesforce/apex"

export default class CaseActivityLog extends LightningElement {
   @api recordId
   @track caseLogs = []
   wiredCaseLogs
   refreshLogsId

   connectedCallback() {
      this.refreshLogsId = registerRefreshHandler(this, this.refreshLogs)
   }

   @wire(getCaseLogs, { caseId: "$recordId" })
   wiredCaseHistory(result) {
      this.wiredCaseLogs = result
      if (result.data) {
         try {
            this.caseLogs = result.data.map((log) =>
               caseActivityLogsService.getCaseEntity(log)
            )
         } catch (error) {
            console.error(error.message)
         }
      } else if (result.error) {
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
         { label: "Updated field", fieldName: "field", type: "text" },
         { label: "Old value", fieldName: "oldValue", type: "text" },
         { label: "New value", fieldName: "newValue", type: "text" },
         { label: "Updated at", fieldName: "date", type: "text" }
      ]
   }

   get isLogsEmpty() {
      return this.caseLogs.length < 0
   }

   disconnectedCallback() {
      unregisterRefreshHandler(this.refreshLogsId)
   }
}

