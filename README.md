# API : Attendee Processing

Manage registration, confirmation, cancellation, and processing of event attendees.
  
## Deployment Details

| Platform       | Database       | URL                                                                 |
|----------------|----------------|---------------------------------------------------------------------|
| Render         | PostgreSQL     | [API Attendee Processing](https://api-attendee-processing.onrender.com/) |

- **Version:** 1.0  
- **Status:** Under development

## Authors 
- [@Jhamile08](https://github.com/Jhamile08)
- [@santiagocherrys](https://github.com/santiagocherrys)
- [@NewNobbie](https://github.com/NewNobbie)
- [@darwingx990](https://github.com/darwingx990)
- [@MateoBermudezMoncada](https://github.com/MateoBermudezMoncada)

## Use Case Examples
  This API is part of a larger system, interacting with:
  - `API_generation_tickets` | ticket generation
    
  - `API_event_reporting` | event reporting

  - It also supports managing multiple tickets associated with events via an admin interface (`UserAttendee`)

## Installation and running

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
- **Ruby on Rails**
  - `ruby` -> `3.2.5`
- **Gems**  
  - `"rails", "~> 7.2.2"`
  - `"pg", ">= 1.1"`
  - `"oas_rails"`
  - `"rack-cors"`
  - `"faker"`
  - `"kaminari"`
    
## Endpoints Overview
- Show all the logs history (Done) -> To consume into API reports
    ```bash
    GET	/attendees/:attendee_id/logs
- Provide a summary of the assistants status (Done)
    ```bash
    GET  /events/:event_id/attendees/summary 
- Allow to do one or many registers (Done)
    ```bash
    POST  /events/:event_id/attendees 
- Send the array with quantity of tickets requirements   (Done)
    ```bash
    GET	/user_attendees/show_user_Attendees
- Change the status to confirm
    ```bash
    PATCH  /attendees/:attendee_id/confirm
- Change the status (Done) 
    ```bash
    PATCH  /attendees/:attendee_id/cancel


### Endpoints To Consume
    GET tickets waiting for the URL


MIT License

Copyright (c) [2024] [Jhamile08]

