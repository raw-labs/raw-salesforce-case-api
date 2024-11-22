
# RAW Salesforce Case Management API Template

## Table of Contents

1. [Introduction](#introduction)
   - [Description](#description)
   - [How It Works](#how-it-works)
   - [Features](#features)
2. [Getting Started](#getting-started)
3. [Overview](#overview)
4. [Endpoints](#endpoints)
5. [Short Intro to RAW APIs](#short-intro-to-raw-apis)
6. [Sample User Requests and LLM Instructions](#sample-user-requests-and-llm-instructions)
7. [Next Steps](#next-steps)
8. [License](#license)
9. [Contact](#contact)

---

## Introduction

### Description

This repository provides a **Salesforce Case Management API Template** using the RAW platform. It demonstrates how to create API endpoints that perform full CRUD (Create, Read, Update, Delete) operations on Salesforce Cases using SQL queries. The template is designed to integrate with chatbots or other applications that need to interact with Salesforce Cases programmatically.

### How It Works

The RAW platform allows you to create APIs by writing SQL queries that interact with Salesforce data. By leveraging RAW's SQL interface to Salesforce, you can perform CRUD operations on Salesforce Cases directly from SQL queries. The endpoints accept query parameters that are injected into the SQL queries using the `:<variable_name>` notation, following RAW's conventions.

**Key Point:** Since the RAW platform supports only GET HTTP methods, the endpoints are designed accordingly to handle CRUD operations via GET requests. While unconventional, this approach allows us to perform necessary operations within the given constraints.

### Features

- **Full CRUD Support**: Create, Read, Update, and Delete Salesforce Cases.
- **Dynamic Querying**: Supports various query parameters to filter and manipulate case data.
- **Integration with Chatbots**: Designed to be consumed by chatbots or other applications.
- **Validation and Error Handling**: Incorporates validation for permissible values to maintain data integrity.
- **Pagination**: Supports pagination in the retrieval endpoint to manage large datasets.
- **Secure Access**: Endpoints are secured and require API keys with appropriate scopes to access.


---

## Getting Started

1. **Deploy the API:**
   - Visit the [Salesforce Case Management Starter Template](https://www.raw-labs.com/templates/salesforce-case-management-starter).
   - Click the **"Get Started"** button to deploy the template.
   - If you don’t have a RAW account, you’ll be prompted to create one for free. Deployment and account setup are seamless—just one click away!

2. **Create an API Key:**
    - Since the endpoints are private and expose sensitive Salesforce data, you need to create an API key with the appropriate scope to access them. See Authentication and Security for detailed instructions.

3. **Explore the API:**
   - Access your API immediately inside the RAW application.
   - View endpoint details and invoke them directly to see how they function, using your API key for authentication.

4. **Customize as Needed:**
   - Modify the API to suit your requirements.
   - Once you’re satisfied, re-publish the changes to make your API available instantly.

---

## Overview

The template focuses on the **Salesforce Case** object, which represents a customer issue or problem that needs resolution.

**Key Fields:**

- **Id**: Unique identifier for the case.
- **CaseNumber**: Auto-generated case number.
- **Subject**: Brief summary of the issue.
- **Description**: Detailed description of the problem.
- **Status**: Current status (e.g., New, Working, Closed).
- **Priority**: Importance level (e.g., Low, Medium, High).
- **Origin**: Source of the case (e.g., Phone, Email, Web).
- **OwnerId**: ID of the user who owns the case.
- **AccountId**: ID of the related account.
- **ContactId**: ID of the related contact.

---

## Endpoints

The following endpoints are available:

1. **GET `/salesforce/api/cases/read`**

   - **Description**: Retrieves Salesforce Cases based on provided filters. Supports pagination.
   - **Query Parameters**: Various parameters to filter cases (e.g., `case_id`, `status`, `priority`, `subject`, `page`, `page_size`).
   - Source code at [/salesforce/api/cases/read.sql](./salesforce/api/cases/read.sql) and endpoint definition at [/salesforce/api/cases/read.yml](./salesforce/api/cases/read.yml).

2. **GET `/salesforce/api/cases/create`**

   - **Description**: Creates a new Salesforce Case with the provided details.
   - **Query Parameters**: Parameters for case creation (e.g., `subject`, `description`, `status`, `priority`).
   - Source code at [/salesforce/api/cases/create.sql](./salesforce/api/cases/create.sql) and endpoint definition at [/salesforce/api/cases/create.yml](./salesforce/api/cases/create.yml).

3. **GET `/salesforce/api/cases/update`**

   - **Description**: Updates an existing Salesforce Case identified by `case_id`.
   - **Query Parameters**: `case_id` (required), and any fields to update.
   - Source code at [/salesforce/api/cases/update.sql](./salesforce/api/cases/update.sql) and endpoint definition at [/salesforce/api/cases/update.yml](./salesforce/api/cases/update.yml).

4. **GET `/salesforce/api/cases/delete`**

   - **Description**: Deletes a Salesforce Case identified by `case_id`.
   - **Query Parameters**: `case_id` (required).
   - Source code at [/salesforce/api/cases/delete.sql](./salesforce/api/cases/delete.sql) and endpoint definition at [/salesforce/api/cases/delete.yml](./salesforce/api/cases/delete.yml).

5. **GET `/salesforce/api/users/read`**

   - **Description**: Returns Salesforce users based on various filters such as username, email, active status, and date ranges. Pagination is supported. All Salesforce entities are created by (created_by_id) and owned by (owner_id) a Salesforce User.
   - **Query Parameters**: Various parameters to filter cases (e.g., `username`, `user_email`, `user_is_active`, `user_department`, `user_id`, `page`, `page_size`).
   - Source code at [/salesforce/api/users/read.sql](./salesforce/api/users/read.sql) and endpoint definition at [/salesforce/api/users/read.yml](./salesforce/api/users/read.yml).

   

---

## Authentication and Security

To ensure the security of sensitive Salesforce data, all endpoints in this API are **private**. Accessing these endpoints requires an API key with the appropriate scope.

### Creating an API Key

1. **Navigate to API Keys in RAW:**

   - Log in to your RAW account.
   - Go to the **API Keys** section from your dashboard.

2. **Create a New API Key:**

   - Click on **"Create API Key"**.
   - Provide a name for your API key (e.g., `Salesforce Case Assistant Key`).

3. **Assign the Required Scope:**

   - Assign the scope `case_assistant:admin` to the API key.
     - This scope corresponds to the `security/scopes` defined in the endpoint YAML files.
   - Ensure that the scope matches exactly to grant access to all endpoints in this API.

4. **Save and Copy Your API Key:**


### Using the API Key

#### In API Calls (e.g., cURL, Postman)

- Include the API key in the `Authorization` header of your HTTP requests.
- **Example using cURL:**

  ```bash
  curl -H "Authorization: x-raw-api-key YOUR_API_KEY_HERE" "https://your-raw-account-hostname/salesforce/api/cases/read?status=Open"
  ```

- **Example using Postman:**

  - In the **Headers** section, add:
    - **Key:** `Authorization`
    - **Value:** `x-raw-api-key YOUR_API_KEY_HERE`

#### With the GPT Chatbot

- Configure the GPT chatbot to include the API key in its requests to the endpoints.
- Ensure that the chatbot's backend securely stores and uses the API key when making API calls.

### Securing Your API Key

- **Keep It Secret:** Do not expose your API key in client-side code, public repositories, or logs.
- **Rotate Regularly:** Rotate your API keys periodically as a security best practice.
- **Access Control:** Limit the scopes and permissions of your API keys to only what is necessary.

### Additional Resources

- **Securing Endpoints Documentation:**

  - Learn more about securing your endpoints in RAW: [Securing Endpoints](https://docs.raw-labs.com/docs/building-api-in-raw/securing-endpoints)

- **API Keys Documentation:**

  - Detailed guide on creating and managing API keys: [API Keys](https://docs.raw-labs.com/docs/api-keys)

---
   
## Short Intro to RAW APIs
In RAW, APIs consist of two parts: a YAML file for endpoint configuration and a SQL file for the query logic. The YAML file path defines the API’s endpoint. For example, /salesforce/api/cases/read.yml corresponds to the API path /salesforce/api/cases/read.

SQL queries can include dynamic parameters using the :<variable_name> syntax. For instance:

```
WHERE case.id = :case_id
```
Here, :case_id becomes a query parameter, accessible via the API as ?case_id=<value>.

To document parameters, enforce types or default values, add metadata at the top of the SQL file as in:

-- @param case_id the ID of the Salesforce Case
-- @type case_id integer  
-- @default case_id null

---

## Sample User Requests and LLM Instructions

This section provides guidance for integrating the Salesforce Case Management API with a Large Language Model (LLM), such as GPT, to enable conversational interactions. The LLM will act as an intelligent assistant that can understand user requests in natural language and interact with the API to manage Salesforce Cases.

The objective is to create an assistant that can perform full CRUD operations on Salesforce Cases based on user queries, while ensuring data integrity, security, and a seamless user experience.

### Objective:

Your goal is to assist users in managing Salesforce Cases by utilizing the endpoints described in the OpenAPI specification. You should perform full CRUD (Create, Read, Update, Delete) operations on Salesforce Cases based on user requests.

### Sample User Questions:

Examples of user queries you should address include, but are not limited to:

- **Create Cases:**
  - "Create a new case for customer ACME Corp regarding a billing issue."
  - "I need to open a case about a login problem with priority 'High'."
  - "Add a case with the subject 'Website down' and description 'The main website is not accessible since 2 PM.'"

- **Retrieve Cases:**
  - "Show me all open cases assigned to me."
  - "What cases were created in the last week?"
  - "Find cases with the subject containing 'password reset'."
  - "List all escalated cases with high priority."
  - "Retrieve all cases related to account ID '001Qy00000KYSRuIAP'."

- **Update Cases:**
  - "Update the status of case number '00001001' to 'Closed'."
  - "Change the priority of case ID '500Qy00000D9rAPIAZ' to 'High'."
  - "Assign case number '00001002' to user 'John Doe'."
  - "Update the reason of case ID '500Qy00000D9rAPIAZ' to 'User Education'."

- **Delete Cases:**
  - "Delete the case with ID '500Qy00000D9rAPIAZ'."
  - "Remove case number '00001003' from the system."

- **Additional Queries:**
  - "Provide the details of case number '00001003'."
  - "What are my tasks for today related to open cases?"
  - "Summarize the cases assigned to user 'Jane Smith'."
  - "List all closed cases for account 'ACME Corp'."

### API Interaction Guidelines:

1. **End-to-End Usage of Endpoints:**

   - Utilize the endpoints described in the OpenAPI spec to fulfill requests accurately.
   - For CRUD operations, use the following endpoints:
     - **Create:** `/salesforce/api/cases/create`
     - **Read (for cases):** `/salesforce/api/cases/read`
     - **Update:** `/salesforce/api/cases/update`
     - **Delete:** `/salesforce/api/cases/delete`
     - **Read (for users / case owners):** `/salesforce/api/users/read`
   - Ensure that all endpoint input parameters are mapped precisely to the user's request.

2. **Handling Input Parameters:**

   - **Required Parameters:**
     - **Create:** `subject` is required.
     - **Update and Delete:** `case_id` is required.
   - **Permissible Values:**
     - **Status:** 'New', 'Working', 'Escalated', 'Closed'
     - **Priority:** 'High', 'Medium', 'Low'
     - **Origin:** 'Phone', 'Email', 'Web'
     - **Type:** 'Question', 'Problem', 'Feature Request'
     - **Reason:** 'Installation', 'User Education', 'Performance', 'Breakdown', 'Hardware Failure', 'Other'
     - Validate these values before making API calls.
   - **String Parameters:**
     - Use exact strings provided by the user for fields like `subject`, `description`, and `reason`.
   - **Date Parameters:**
     - Convert relative dates (e.g., "last week") to the appropriate date range in 'YYYY-MM-DD' format.
   - **Avoid Null or Empty Parameters:**
     - Ensure all required parameters are provided.
     - Do not pass null or empty values unless intended.

3. **Intelligent Mapping of Inputs:**

   - Infer implicit inputs where possible.
     - If a user mentions a case by `case_number`, retrieve the corresponding `case_id` first.
     - Map user names to their `owner_id` when assigning cases.
   - For priorities like "urgent," map to the permissible value 'High' if appropriate.

4. **Validation of Inputs:**

   - Confirm that provided values are within the permissible options.
   - If an invalid value is detected, prompt the user to correct it.
     - Example: "The status 'In Progress' is invalid. Please choose from 'New', 'Working', 'Escalated', or 'Closed'."

5. **Provide Detailed Responses:**

   - Include all relevant details in your responses.
     - For retrieval requests, present case details such as `case_number`, `subject`, `status`, `priority`, and `created_date`.
   - When confirming updates or deletions, acknowledge the action and the affected case.
     - Example: "Case '00001001' has been updated to status 'Closed'."

6. **Handling Ambiguous Queries:**

   - If the user's request lacks necessary information, ask for clarification.
     - Example: "Please provide the case number or ID to proceed with the update."

7. **Verification Step Before Deletion:**

   - **Before performing a deletion, always confirm with the user.**
     - When a user requests to delete a case, respond by summarizing the case details and asking for confirmation.
     - Example:
       - "You are about to delete case '00001003' with the subject 'Billing issue'. This action cannot be undone. Do you wish to proceed?"
     - Only proceed with the deletion if the user explicitly confirms.
     - If the user cancels or does not confirm, do not perform the deletion and inform the user that the operation has been canceled.

8. **Pagination:**

   - For queries that may return many results, use pagination.
     - Default `page_size` is 10.
     - Ask the user if they want to see more after displaying the initial results.
     - Use `page` and `page_size` parameters to control pagination.

9. **Error Handling and Clarifications:**

   - Inform the user if an operation cannot be completed.
     - Example: "No case found with ID '12345'. Please check the ID and try again."
   - If the API returns an error, explain it in user-friendly terms.

10. **Current Date Awareness:**

    - Keep track of the current date for handling date-related queries accurately.

11. **Security and Data Privacy:**

    - Do not expose sensitive information.
    - Ensure compliance with data privacy regulations.

### Hierarchical Navigation of Entities:

- **Relationships:**

  - Cases may be related to Accounts, Contacts, or Users.
  - Use these relationships to fulfill user requests that reference these entities.

- **Examples:**

  - **Retrieve Cases for an Account:**
    - Find the `account_id` using the account name provided by the user.
    - Use `account_id` to filter cases.
  - **Assign Case to a User:**
    - Retrieve `owner_id` based on the user's name.
    - Update the case with the new `owner_id`.

### Additional Notes:

- **Data Formats:**

  - Dates should be in 'YYYY-MM-DD' format.
  - Booleans are `true` or `false`.

- **Response Formatting:**

  - Present information clearly and concisely.
  - Use bullet points or numbered lists for readability if necessary.

--- 

## Next Steps

Visit the [Salesforce Case Management Starter page](https://www.raw-labs.com/templates/salesforce-case-management-starter), deploy this template and get started using RAW.

When you create your RAW account, you will be able to view and run these endpoints in the RAW catalog, as well as quickly modify these endpoints or create new ones in the RAW workspace, in our easy-to-use web IDE.

**Remember:** Before invoking the endpoints, create an API key with the required scope (`case_assistant:admin`) and include it in your API calls as described in the Authentication and Security section.

---

## License

This project is licensed under the **Apache License 2.0**. See the [LICENSE](LICENSE) file for details.

---

## Contact

- **Email**: [support@raw-labs.com](mailto:support@raw-labs.com)
- **Website**: [https://raw-labs.com](https://raw-labs.com)
- **Twitter**: [@RAWLabs](https://twitter.com/raw_labs)
- **Community Forum**: [Forum](https://www.raw-labs.com/community)

For more information, visit our [documentation](https://docs.raw-labs.com/).
