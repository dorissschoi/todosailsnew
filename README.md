# Todo
Mark todo list app. When user create a task, a notification message will be sent to user's IM account. 
# Server API
# todo
```
get /api/todo - list all user todo task
get /api/todo?ownedBy=username - read task of the specified username
get /api/todo?ownedBy=me - read task of current login user
post /api/todo - create todo task
put /api/todo/:id - update task of the specified id
delete /api/todo/:id - delete task of the specified id
```
# user
```
get /api/user - list all user
get /api/user/me - list login user 
```
# Configuration


*   git clone https://github.com/dorissschoi/todosailsnew.git
*   cd todosailsnew
*   npm install && bower install
*   update environment variables in config/env/development.coffee for server
```
port: 3000
connections:
    mongo:
        driver:     'mongodb'
        host:       'localhost'
        port:       27017
        user:       'todosailsrw'
        password:   'password'
        database:   'todosails'
```
*	update environment variables in www/js/env.cofffee for client
```
client_id:      'todoDEV'
```
*   node_modules/.bin/gulp --prod=prod
*   sails lift --dev