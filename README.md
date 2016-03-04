# Hicube

Hicube is Rails & MongoDB based CMS. Hicube aims to provide rails developers with quickstart to a simple CMS.

## Getting Started

Hicube works with Rails 4.2 onwards. You can add it your Gemfile with:

```ruby
gem 'hicube'
```

Run the bundle command to install it.

**If you have root path setup in your routes.rb then comment it out for next steps (this should be fixed in later releases).**

After installing Hicube run the generator:

```console
bundle exec rails generate hicube:install
```

The generator will install configurations and migrations to setup default account for your CMS. When you are done, you are ready to update route to mount Hicube engine within your rails application. Add following code in your routes.rb

```ruby
mount Hicube::Engine => '/hicube', as: 'hicube'
```

## Configuration

Hicube uses S3 Bucket for asset storage by default as well as SES for email sending part.

```console
export S3_BUCKET_NAME=<bucket name on S3>
export AWS_ASSET_HOST=<full url of asset host>
export AWS_ACCESS_KEY_ID=<access key id from AWS>
export AWS_ACCESS_KEY=<access key from AWS>
export AWS_SMTP_USERNAME=<username from SES>
export AWS_SMTP_PASSWORD=<password from SES>
```

Next, add action mailer config settings to development.rb. At this stage, you can also add it to all other environments e.g. staging, test & production

```ruby
  ActionMailer::Base.smtp_settings = {
    :address  => 'email-smtp.us-east-1.amazonaws.com',
    :port     => 587,
    :enable_starttls_auto => true,
    :user_name => ENV['AWS_SMTP_USERNAME'],
    :password => ENV['AWS_SMTP_PASSWORD']
  }
```

Finally, setup application name in your app locales e.g. en.yml

```yaml
en:
  app:
    name: 'My Website Name'
```

You should now start your application server and hit following in your browser

```console
localhost:3000/hicube/sign_in
```

Use following credentials - _admin@example.com_ & password - _admin_

### Adding Content

Add all css and js that your website requires into application.css and application.js as per any other rails application.

You can add content in Slim format in Raw Content Tab.

**Optional -** You can delete application.html.slim within your project as it is not used by Hicube.


## Heroku

If you have not done already, move configuration settings above to production/staging before pushing to heroku.

Additonally, it is highly recommended to use 'puma' gem in production on heroku. Finally, follow Heroku docs to push app to heroku as well as add mongodb addon.


## License

This project rocks and uses MIT-LICENSE.