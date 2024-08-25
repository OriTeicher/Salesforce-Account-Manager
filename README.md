
# Salesforce Account Manager

## Intro
This project contains multiple LWC components and Apex processes designed to improve the Salesforce user experience by tracking changes, managing account details, and automating case comment creation
You are more than welcome to clone this code to your local machine!

## Components
### 1. Case Activity Log Component
Purpose: Displays an activity log on the Case page layout, reflecting changes made to the Case record.
Functionality:
- Automatically refreshes to show updates each time a Case field is modified, listing the changed fields and their new values.
- Enhances visibility into Case modifications directly on the page layout.
  
![RecentlyViewed_Cases_Salesforce-GoogleChrome2024-06-3014-50-40-ezgif com-video-to-gif-converter](https://github.com/OriTeicher/Home-Assignment-Tnuva/assets/101281765/8581229a-cb6c-422a-b88f-e9fe395f0acf)


### 2. Account Management Component
Purpose: Placed on the Account Lightning Record page to manage Account details and associate Contacts.
Features:
- Displays input fields for Account Phone, Type, and Description.
- Includes a table listing up to 10 unassociated Contacts with options to select and associate them with the Account.
- A "Save" button updates the Account details.
- A "Select" button associates the contact to the user.
- Provides success or failure messages after operations.
  
![AllAccounts_Accounts_Salesforce-GoogleChrome2024-06-3014-51-14-ezgif com-video-to-gif-converter](https://github.com/OriTeicher/Home-Assignment-Tnuva/assets/101281765/7fa64ed1-dba6-4ee1-9c70-c5a3ac5beee6)

### 3. Server-Side Processes
Case Comment Creation Process
- Purpose: Automates the creation of Case Comments.
- Functionality: Triggers on the creation of a new Case record, generating 20,000 Case Comment records under the newly created Case.
 The start method retrieves Case IDs based on a specific caseId parameter. In the execute method, it checks if there are any comments to insert and does so if the list is not empty; otherwise, it logs a debug message indicating no comments were found. The finish method checks if the number of created comments is less than a predefined amount, and if so, it initiates another batch process with the remaining records. If all comments are successfully created, it logs the total count of inserted comments.

![sssss](https://github.com/OriTeicher/Home-Assignment-Tnuva/assets/101281765/7bdc0756-f58f-439f-9db0-d9f74b4d947e)

## Installation
- Clone the repository to your local machine using:
```bash
git clone https://github.com/OriTeicher/Salesforce-Account-Manager
```
- Deploy the component to your Salesforce org using Salesforce CLI or other deployment tools.
- Add the component to the desired Lightning page layout or Lightning App Builder.

