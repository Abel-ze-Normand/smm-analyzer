# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

## Ruby version
ruby 2.4.0

## System dependencies
Install ruby based on your unix-system:

### MacOS
most handy way to install with Homebrew:
```bash
brew install ruby
```

### Linux
install from your packet manager, just be sure that 2.4.0 version is installed. for example, on Archlinux:
```bash
sudo pacman -S ruby
```

or for Fedora:
```bash
yum install ruby
```

### Windows
just go fuck yourself

After ruby installation install rails libraries with:
```bash
gem install rails
```

## Initial setup
after ruby and rails installation move to project path and load dependencies:
```bash
bundle install
```

then, load migrations:
```bash
rake db:migrate
```

N.B.: Keep in mind, if there will be some error related with db initialization, setup db manually:
```bash
rake db:init && rake db:setup && rake db:migrate
```

and now you are safe to start server with:
```bash
rails s
```

check http://localhost:3000 . There should be no errors
