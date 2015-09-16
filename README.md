# stats19

The stats19 project creates a SQL database to hold STATS19 road collision data
published by the UK government.

Read STATS20 to help you understand the data and how it is entered.

Basic instructions
==================

Get the data
------------

Visit http://data.gov.uk/dataset/road-accidents-safety-data

Download the data described:
  "All STATS19 data (accident, casualties and vehicle tables) for 2005 to 2014"

In 2014 this saved as a 103Mb file called Stats19_Data_2005-2014.zip
  
unzip this file inside the following directory:
  
  cd data/core-tables
  unzip Stats19_Data_2005-2014.zip
  ls
    Accidents0514.csv       
    Casualties0514.csv
    Vehicles0514.csv
  

Create the database
-------------------
  
The bin directory contains shell scripts to create a new database for you.
Choose the appropriate command for your database vendor.


PostgreSQL
----------
Assuming your PostgreSQL installation is simple and trusts localhost users,
create your database as follows:

  cd bin
  ./postgres-create-db
  ./postgres-load-data
  
The data loading takes 10 minutes or so.
  
You should now have a stats19 database and user. You could connect like this:

  psql stats19 stats19
