# API Attendee Processing

## 1. Introduction

- **API Name:** `api-attendee-processing`
- **Description:** Manage registration, confirmation, cancellation, and processing of event attendees.
- **Use Case Examples:**  
  This API is part of a larger system, interacting with:
  - `API_generation_tickets` (ticket generation)
  - `API_event_reporting` (event reporting)  
  It also supports managing multiple tickets associated with events via an admin interface (`UserAttendee`).
- **Version:** 1.0  
- **Status:** Under development

---

## 2. Getting Started

### Prerequisites
- **Ruby on Rails**
  - `ruby` -> `3.2.5`
- **Gems**  
  - `"rails", "~> 7.2.2"`
  - `"pg", ">= 1.1"`
  - `"oas_rails"`
  - `"rack-cors"`
  - `"faker"`
  - `"kaminari"`

### Installation
1. Clone the repository:  
   ```bash
   git clone https://github.com/Jhamile08/api-attendee-processing.git

2. Navigate to the project directory:  
   ```bash
   cd api-attendee-processing

   cd api-attendee-processing

    bundle install
   
    rails db:prepare 

3. Endpoints Overview
    ```bash
    GET	/attendees/:attendee_id/logs | Show all the logs history (Done) -> To consume into API reports
    GET  /events/:event_id/attendees/summary | Provide a summary of the assistants status (Done)
    POST	/events/:event_id/attendees  | Allow to do one or many registers (Done)
    GET	/user_attendees/show_user_Attendees | Send the array with quantity of tickets requirements   (Done)
    PATCH  /attendees/:attendee_id/confirm | Change the status (Done)
    PATCH  /attendees/:attendee_id/cancel | Change the status (Done)


3.1 Endpoints To Consume

    GET tickets waiting for the URL

4. Deployment | Render DB ´pg´
   ```bash
   https://api-attendee-processing.onrender.com/

MIT License

Copyright (c) [2024] [Jhamile08]

