Object of this code:

* Be able to query, manipulate, and save rows in an array via URLs
* Be able to create an app that uses conditionals to execute different branches of code
* Be able to appropriate format responses
* Be able to handle errors

Requirements:

* Code must adhear to the ruby style guide.


Steps to achieve the above objectives:

* Create an array of users. The users Array be full of hashes that have first_name, last_name, and age as fields.
* Given this request GET http://localhost:3000/users HTTP/1.1 I should see ALL the users from the array printed out to me with an appropriate response code.
* Given this request GET http://localhost:3000/users/1 HTTP/1.1 I should see ONLY the user from the array at that index.
* Given this request GET http://localhost:3000/users/9999999 HTTP/1.1 I should see a message saying it was not found and the appropriate response code returned to me.
* Given this request GET http://localhost:3000/users?first_name=s I should see ALL users from the array where first_name starts with s.
* Given this request GET http://localhost:3000/users?limit=10&offset=10 I should see ONLY 10 users with id of greater than 10 (There must be 20 users in your db minimum)
* Given this request DELETE http://localhost:3000/users/1 I should have the user associated with that ID deleted from the array and an appropriate response returned to me.
