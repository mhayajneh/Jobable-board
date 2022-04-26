# README

Project API built with ruby

1) /signup METHOD: POST
    params :name, email, password,password_confirmation

2) auth/login METHOD: POST
    params :email, password

3) /changeAdmin METHOD: POST ==> can only be one admin
    params: email

4) /jobs METHOD: GET
    * Fitlers
    * /jobs?title=Software
    * /jobs?created_at=2015

       
5)  /jobs/:id METHOD: GET


6)  /jobs METHOD: POST ==> for creating job only admin can create
    params:title, description

7)  /jobs/:id METHOD: PUT ==> for creating job only admin can update
    params:title, description

8)  /jobs/:id METHOD: DELETE ==> only admin can delete

9)  /jobs/:job_id/applications METHOD: GET ==> return job applications 

10)  /jobs/:job_id/applications METHOD: POST ==> Apply application


11)  /jobs/:job_id/applications/:id METHOD: GET ==> return single application

to run tests: bundle exec rspec spec/auth -fd bundle exec rspec    
