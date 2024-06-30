
# Home Assignment 

## Components
### 1. Case Activity Log Component
Purpose: Displays an activity log on the Case page layout, reflecting changes made to the Case record.
Functionality:
- Automatically refreshes to show updates each time a Case field is modified, listing the changed fields and their new values.
- Enhances visibility into Case modifications directly on the page layout.
  
### 2. Account Management Component
Purpose: Placed on the Account Lightning Record page to manage Account details and associate Contacts.
Features:
- Displays input fields for Account Phone, Type, and Description.
- Includes a table listing up to 10 unassociated Contacts with options to select and associate them with the Account.
- A "Save" button updates the Account details.
- A "Select" button associates the contact to the user. 
- Provides success or failure messages after operations.
  
### 3. Server-Side Processes
Case Comment Creation Process
- Purpose: Automates the creation of Case Comments.
- Functionality: Triggers on the creation of a new Case record, generating 20,000 Case Comment records under the newly created Case.
![code](https://github.com/OriTeicher/Home-Assignment-Tnuva/assets/101281765/72e6d11b-1484-4a3b-9205-8bd99c43a28a)

## Installation
- Clone the repository to your local machine using:
```bash
git clone  git clone https://github.com/OriTeicher/Home-Assignment-Tnuva.git
```
- Deploy the component to your Salesforce org using Salesforce CLI or other deployment tools.
- Add the component to the desired Lightning page layout or Lightning App Builder.

