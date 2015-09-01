[![Build Status](https://travis-ci.org/johnmarinelli/threetapsapi.svg?branch=master)](https://travis-ci.org/johnmarinelli/threetapsapi)

# Three Taps API Ruby Client

*3taps is an exchange platform dedicated to keeping public facts publicly accessible. We collect, organize, and distribute exchange-related data for developer use. The Data Commons is open to all posting sources and developers interested in creating fair and efficient markets. All transaction-specific information is available at the same time, to everyone.* - <https://3taps.com>

---

## Example Usage (Search)
``` ruby
ttc = ThreeTapsAPI::Search.new

# to enter parameters, just use dot notation
ttc.location.zipcode = 'USA-02478'
ttc.radius = 50

# you are notified of an invalid parameter
ttc.invalid = 'nope' # => invalid is not a valid parameter.
```

## Example Usage (Reference)
``` ruby
ttc = ThreeTapsAPI::Reference.new

# as above, just use dot notation to retrieve a reference
ttc.categories # => JSON object response from reference.3taps.com

# and you are still notified of an invalid parameter
ttc.invalid # => invalid is not a valid parameter.
```
