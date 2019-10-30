# README
Crewmeister coding challenge

Implementation of a .ical file generator from given .json files and an Api class.

# Usage:
Install ruby 2.5.1

Install Rails 6.0.0

Run rails t to assert all tests are working properly

Run rails server to get the application running

Access localhost:3000/ to download the full .ical file

Parameters: 

 * userId=xxxx => download .ical file with events from a specific user
  
 * startDate=yyyy-mm-dd&endDate=yyyy-mm-dd => download .ical file with events happening within the date interval specified
 
 * These parameters can also be used together e.g. http://localhost:3000?userId=2664&startDate=2017-01-01&endDate=2017-02-01 
