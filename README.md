# Goedel

Generate activerecord create statements from activerecord data

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'goedel'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install goedel

## Usage

```ruby
# assume User is active record model with `id`, `email`, `name`, and `address`
last_user = User.last

pp last_user.attributes
=> {
     "id" => 123,
     "created_at" => Tue, 22 Dec 2015 08:34:14 UTC +00:00,
     "updated_at" => Tue, 22 Dec 2015 08:34:14 UTC +00:00,
     "email" => "goedel@incompleteness.com"
   }

Goedel.goedel(last_user)

# will print out activerecord create statement which can create the data object
User.create(
  created_at: Time.zone.parse("2015-22-12 08:34:14"),
  updated_at: Time.zone.parse("2015-22-12 08:34:14"),
  id: 123,
  email: "goedel@incompleteness.com",
  name: "Goedel"
)

# and then return it as a string
=> "User.create(\n  id: 123,\n  email: \"goedel@incompleteness.com\",\n  name: \"Goedel\", \n  address: \"123 Recurse St. Princeton, New Jersey\""

# Not all a record's attributes will show up sometimes, especially those delegated through associations.
# You can force these attributes to show up

# Suppose that the user's address is delegated to a `home` object
# `address` would normally not show up as an attribute, but you can
# force it by adding it in the attributes option like so

Goedel.goedel(last_user, force_attributes: [:address])

User.create(
  created_at: Time.zone.parse("2015-22-12 08:34:14"),
  updated_at: Time.zone.parse("2015-22-12 08:34:14"),
  id: 123,
  email: "goedel@incompleteness.com",
  name: "Goedel", 
  address: "123 Incomplete St. Princeton, New Jersey"
)

# You can also override attribute values

Goedel.goedel(
  last_user, 
  force_attributes: [:address],
  override_attributes: {"email" => "hide_email@fake.com, }
)

```

#### Compatability

Tested with ActiveRecord 4.2.1

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/goedel. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

