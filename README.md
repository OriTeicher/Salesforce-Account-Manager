
# Home Assignment 

## Intro
This project contains multiple LWC components and Apex processes designed to improve the Salesforce user experience by tracking changes, managing account details, and automating case comment creation
You are more than welcome to clone this code to your local machine!

## Components
#### 1. Case Activity Log Component
Purpose: Displays an activity log on the Case page layout, reflecting changes made to the Case record.
Functionality:
- Automatically refreshes to show updates each time a Case field is modified, listing the changed fields and their new values.
- Enhances visibility into Case modifications directly on the page layout. ![ssaasd](https://github.com/OriTeicher/Home-Assignment-Tnuva/assets/101281765/f7e36776-be9a-4f81-8af1-8cdee2de19cf)

#### 2. Account Management Component
Purpose: Placed on the Account Lightning Record page to manage Account details and associate Contacts.
Features:
- Displays input fields for Account Phone, Type, and Description.
- Includes a table listing up to 10 unassociated Contacts with options to select and associate them with the Account.
- A "Save" button updates the Account details.
- A "Select" button associates the contact to the user.
- Provides success or failure messages after operations.
 ![save3](https://github.com/OriTeicher/Home-Assignment-Tnuva/assets/101281765/8e9fdbc3-f5d2-41a7-80b5-929a78909646)

#### 3. Server-Side Processes
Case Comment Creation Process
- Purpose: Automates the creation of Case Comments.
- Functionality: Triggers on the creation of a new Case record, generating 20,000 Case Comment records under the newly created Case.
![code](https://github.com/OriTeicher/Home-Assignment-Tnuva/assets/101281765/72e6d11b-1484-4a3b-9205-8bd99c43a28a)

## Installation
- Clone the repository to your local machine using:
```bash
git clone https://github.com/OriTeicher/Home-Assignment-Tnuva.git
```
- Deploy the component to your Salesforce org using Salesforce CLI or other deployment tools.
- Add the component to the desired Lightning page layout or Lightning App Builder.

