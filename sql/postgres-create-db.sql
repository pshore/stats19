/* ---------------------------------------------------------------------
Create the database - to be run as a PostgreSQL superuser.

This takes 1 parameter - the name of the database to create stored in
a variable named 'db'. Invoke from psql as follows:

  psql postgres postgres -f create-db.sql -v db=stats19
--------------------------------------------------------------------- */

-- *********************************************************************
-- Create the database, dropping it first if it already exists.

\connect postgres postgres
SET client_min_messages='WARNING';

\set dbuser 'stats19'

DROP DATABASE IF EXISTS :db ;
CREATE DATABASE :db ;

-- set default datestyle to match csv data, simplifies using COPY command
--SET datestyle TO "ISO, DMY";
ALTER DATABASE :db SET datestyle TO "ISO, DMY";

-- *********************************************************************
-- Install the basic language features we need.

\connect :db postgres
SET client_min_messages='WARNING';

CREATE LANGUAGE plpgsql;

-- *********************************************************************
-- Create the user.

DROP USER IF EXISTS :dbuser ;
CREATE USER :dbuser ;

\connect :db :dbuser
SET client_min_messages='WARNING';

-- *********************************************************************
-- Create the tables 

\i tables.sql

-- *********************************************************************
-- Create the functions.

CREATE AGGREGATE array_accum (anyelement)
(
  sfunc = array_append,
  stype = anyarray,
  initcond = '{}'
);

-- *********************************************************************
-- Create the views

\i views.sql

