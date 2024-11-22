
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
7. [Next Steps](#support-and-troubleshooting)
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

---

## Getting Started

1. **Deploy the API:**
   - Visit the [Salesforce Case Management Starter Template](https://www.raw-labs.com/templates/salesforce-case-management-starter).
   - Click the **"Get Started"** button to deploy the template.
   - If you don’t have a RAW account, you’ll be prompted to create one for free. Deployment and account setup are seamless—just one click away!

2. **Explore the API:**
   - Access your API immediately inside the RAW application.
   - View endpoint details and invoke them directly to see how they function.

3. **Customize as Needed:**
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
   - **Query Parameters**: Various parameters to filter cases (e.g., `username`, `user_email`, ``, `subject`, `page`, `page_size`).
   - Source code at [/salesforce/api/users/read.sql](./salesforce/api/users/read.sql) and endpoint definition at [/salesforce/api/users/read.yml](./salesforce/api/users/read.yml).

   
## Short Intro to RAW APIs
In RAW, APIs consist of two parts: a YAML file for endpoint configuration and a SQL file for the query logic. The YAML file path defines the API’s endpoint. For example, /salesforce/api/cases/read.yaml corresponds to the API path /salesforce/api/cases/read.

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

## Next Steps

Visit the [Salesforce Case Starter page](https://www.raw-labs.com/templates/salesforce-case-api-starter), deploy this template and get started using RAW.

When you create your RAW account, you will be able to view and run these endpoints in the RAW catalog, as well as quickly modify these endpoints or create new ones in the RAW workspace, in our easy-to-use web IDE.

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
