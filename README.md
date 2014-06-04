
Time Tracker [![Build Status](https://travis-ci.org/bahelms/time_tracker.svg?branch=master)](https://travis-ci.org/bahelms/time_tracker)
----

Time Tracker is an app that allows you to keep track of the time you spend on 
tasks.


TODO
----
* Function to combine all of the same tasks into one
* Show summary task times for the day for logging 
* Fix oversized layout on task index
* Delete Tasks
* Add project after task is created
* Add task name after task is created
* Boolean for logged time
* Fix reset password mailer
* Use unicorn server
* Have tasks span multiple days? Would need to have calendar for manual input

Prod Problems
----
* Times are local to wherever the heroku server is
* Applying new time while task is running shows incomplete task after ajax
* New project is not inserting via ajax, it just displays the full partial
* Session timeout is too short; still says true on session timeout redirect

Test
----
* JS tests
* Task Decorator
* Dashboard stopwatch feature
