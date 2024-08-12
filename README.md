# cell_number_app

# Project Description

I am Creating a flutter app that has a login page which links to the user schema on the provided test db.

 

The app would need to link to the hsbc_cellnumberlink table and display them in a list on the first page. If the number has expired highlight it in red, if it is a month from expiring, highlight it in orange.

 

The app would also need to able to assign a number to a hub. It would need a dropdown of current hubs on DB and have the field to insert a number and choose an expiry date

# File Description

## main.dart:

Entry point of the app. Defines the routes and initializes the app.

## screens/:

Contains the UI screens of the app.

### login_page.dart:

The login screen where users enter their credentials.

### home_page.dart:

The main screen displaying the list of cell numbers.

### assignment_page.dart:

The screen for assigning a cell number to a hub.

## services/:

Contains the database service for handling database operations.

### database_service.dart:

Manages database initialization and interactions.

## models/:

Contains data models used in the app.

### cell_number.dart:

Defines the data model for cell numbers.

## widgets/:

Contains reusable UI components.

### cell_number_tile.dart:

A widget for displaying each cell number in the list.

## utils/:

Contains utility classes and functions.

### constants.dart:

Stores constant values used throughout the app.

### validators.dart:

Contains input validation functions.

