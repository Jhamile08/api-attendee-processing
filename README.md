# API : Attendee Processing

## Description
---
Manage registration, confirmation, cancellation, and processing of event attendees.
  
-> Deployment | Render DB **PostgreSql**
https://api-attendee-processing.onrender.com/
- **Version:** 1.0  
- **Status:** Under development

## Authors 
---
- @Jhamile08
- @santiagocherrys
- @NewNobbie
- @darwingx990
- @MateoBermudezMoncada

## Use Case Examples
---
  This API is part of a larger system, interacting with:
  - `API_generation_tickets` | ticket generation
    
  - `API_event_reporting` | event reporting

  - It also supports managing multiple tickets associated with events via an admin interface (`UserAttendee`)

## Installation and running
---

1. Clone the repository:  
   ```bash
   git clone https://github.com/Jhamile08/api-attendee-processing.git
2. Navigate to the project directory:  
   ```bash
   cd api-attendee-processing
3. Install dependencies:
   ```bash
    bundle install
4. Prepare the DB - Schema - Models
   ```bash
    rails db:prepare
5. Run the project:
   ```bash
   rails s

### Extra - Configuration 
---
- **Ruby on Rails**
  - `ruby` -> `3.2.5`
- **Gems**  
  - `"rails", "~> 7.2.2"`
  - `"pg", ">= 1.1"`
  - `"oas_rails"`
  - `"rack-cors"`
  - `"faker"`
  - `"kaminari"`

3. Endpoints Overview
    GET	```/attendees/:attendee_id/logs```         | Show all the logs history (Done) -> To consume into API reports
    GET  ```/events/:event_id/attendees/summary``` | Provide a summary of the assistants status (Done)
    POST	```/events/:event_id/attendees```        | Allow to do one or many registers (Done)
    GET	```/user_attendees/show_user_Attendees```  | Send the array with quantity of tickets requirements   (Done)
    PATCH  ```/attendees/:attendee_id/confirm```   | Change the status (Done)
    PATCH  ```/attendees/:attendee_id/cancel```    | Change the status (Done)


3.1 Endpoints To Consume

    GET tickets waiting for the URL


MIT License

Copyright (c) [2024] [Jhamile08]

Copyright (c) [2024] [Jhamile08]

