# Ruby on rails code trustworthy tools

The gems below are the ones being used here on codelitt to ensure that the code made is readable, maintanable and secure.

### Code quality

#### Rubocop
It is a lint for ruby/rails applications. More informations [here](https://github.com/bbatsov/rubocop)

###### Install
```
Inside your gemfile
group :development, :test do
  gem 'rubocop'
end
```

Here on codelitt we've a set of customized rules that we put inside our .rubocop.yml

```
AllCops:
  TargetRubyVersion: 2.2

  Include:
    - '**/config.ru'
  Exclude:
    - 'vendor/**/*'
    - 'db/**/*'
    - 'db/schema.rb'
    - 'bin/**/*'

Rails:
  Enabled: true

Metrics/LineLength:
  Max: 120

Style/Documentation:
  Enabled: false

Style/BlockDelimiters:
  Enabled: false

Metrics/MethodLength:
  Max: 15

Style/IndentArray:
  Enabled: false

Style/Lambda:
  Enabled: false

Style/TrailingCommaInLiteral:
  Enabled: true
  EnforcedStyleForMultiline: comma

Style/GuardClause:
  Enabled: false
```

###### Usage
```
Inside your root folder:
Check code style
    rubocop

Autofix
    rubocop -a
```
    
##### CI config

`rubocop`

#### Rubycritic
It is a code validation for ruby/rails applications, it checks for code smells, duplicated code and so on. More informations [here](https://github.com/whitesmith/rubycritic)

###### Install
```
Inside your gemfile
group :development, :test do
  gem 'rubycritic'
end
```

###### Usage
```
Inside your root folder:
    rubycritic
```

##### CI config

`rubycritic --mode-ci --path $CIRCLE_ARTIFACTS/rubycritic`

### Code coverage

#### Simplecov
It is a code coverage gem. More informations [here](https://github.com/colszowka/simplecov)

###### Install
```
Inside your gemfile
group :development, :test do
  gem 'simplecov'
end
```

###### Usage
```
Add the code below inside your spec_helper.rb
    require 'simplecov'
    SimpleCov.start

This gem has a config to make the the tests fail if the code coverage is under a %, just add the code below inside spec_helper:

    SimpleCov.minimum_coverage 90
```
### Project security

#### Brakeman
Is a static analysis tool which checks Ruby on Rails applications for security vulnerabilities. More information [here](https://github.com/presidentbeef/brakeman)

###### Install
```
Inside your gemfile
group :development, :test do
  gem 'brakeman'
end
```

###### Usage
```
Inside your root folder:
    brakeman
```

##### CI config

`bundle exec brakeman --exit-on-warn -o $CIRCLE_ARTIFACTS/brakeman.html`

#### Dawn
Is a code scanner designed to review your ruby code for security issues. More information [here](https://github.com/thesp0nge/dawnscanner)

###### Install
```
https://github.com/thesp0nge/dawnscanner#installation
```

###### Usage
```
Inside your root folder:
    bundle exec dawn -C --exit-on-warn -c codesake-dawn.yaml --html -F dawn.html .
```

##### CI config

`bundle exec dawn -C --exit-on-warn -c codesake-dawn.yaml --html -F $CIRCLE_ARTIFACTS/dawn.html .`
