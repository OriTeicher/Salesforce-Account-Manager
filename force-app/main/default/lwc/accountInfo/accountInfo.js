import { LightningElement, api, wire, track } from "lwc"
import getAccountDetails from "@salesforce/apex/AccountController.getAccountDetails"
import getUnassociatedContacts from "@salesforce/apex/AccountController.getUnassociatedContacts"
import updateAccountInfo from "@salesforce/apex/AccountController.updateAccountInfo"
import { ShowToastEvent } from "lightning/platformShowToastEvent"

export default class AccountInfo extends LightningElement {
   @api recordId
   @track account
   @track contacts
   @track selectedContactId
   @track phone
   @track type
   @track description

   @wire(getAccountDetails, { accountId: "$recordId" })
   wiredAccount(result) {
      const { error, data } = result
      if (data) {
         this.account = data
         this.phone = data.Phone
         this.type = data.Type
         this.description = data.Description
      } else if (error) {
         this.showUserMsg("Error", "Error loading account data", "error")
      }
   }

   @wire(getUnassociatedContacts)
   wiredContacts({ error, data }) {
      if (data) {
         this.contacts = data
      } else if (error) {
         this.showUserMsg("Error", "Error loading contacts data", "error")
      }
   }

   handleInputChange(event) {
      const field = event.target.name
      if (field === "phone") {
         this.phone = event.target.value
      } else if (field === "type") {
         this.type = event.target.value
      } else if (field === "description") {
         this.description = event.target.value
      }
   }

   async handleContactSelect(event) {
      const contactId = event.target.dataset.id
      this.selectedContactId = contactId
      await this.handleSubmit(`Contact ${contactId} linked to your account!`)
   }

   async handleSubmit(successMsg = "Account updated!") {
      try {
         await updateAccountInfo({
            accountId: this.recordId,
            phone: this.phone,
            type: this.type,
            description: this.description,
            contactId: this.selectedContactId
         })
         this.showUserMsg(successMsg, "Account updated!", "success")
      } catch (error) {
         console.error("Error: ", error.message)
         this.showUserMsg("Error", "Error updating account", "error")
      }
   }

   showUserMsg(title, message, variant) {
      const userMsgEvent = new ShowToastEvent({
         title,
         message,
         variant
      })
      this.dispatchEvent(userMsgEvent)
   }
}
