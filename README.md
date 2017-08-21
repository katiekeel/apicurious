## Apicurious

### Summary

This [cleverly named](http://www.epicurious.com/) project is an exploration of API consumption and presentation within Rails.

The project uses OmniAuth and the Github API to display users profile information, recent activity, activity from users one follows, organizations one belongs to, and a list of one's repositories.

#### Versions and stuff

This project was created using Ruby 2.4 and Rails 5.1.3.

#### Setup

`$ git clone git@github.com:katiekeel/apicurious.git`
`$ bundle`
`$ rails db:create db:migrate`

#### Navigation

`localhost:3000`

#### Testing

`$ rails db:test:prepare`
`$ rspec`
