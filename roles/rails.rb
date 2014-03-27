require 'securerandom'
ruby_version = "2.0.0-p353" # change ruby version here

name "rails"
description "Provisions server for rails app installation"

run_list(
  # base packages
  "recipe[apt]",
  "recipe[vim]",
  "recipe[chef-solo-search]",
  "recipe[users::sysadmins]",
  "recipe[openssh]",
  "recipe[sudo]",
  "recipe[fail2ban]",
  "recipe[curl]",
  "recipe[curl::devel]",
  "recipe[ufw]",
  # nginx, postgresql and ruby/rails related packages
  "recipe[nginx]",
  "recipe[postgresql::client]",
  "recipe[postgresql::server]",
  "recipe[ruby_build]",
  "recipe[rbenv::user]",
  "recipe[imagemagick]",
  "recipe[imagemagick::devel]",
  "recipe[nodejs]",
  "recipe[nodejs::npm]",
  "recipe[xslt]",
  "recipe[libxml2]"
)

# configuration options for the above cookbooks
default_attributes({
  "openssh" => {
    "server" => {
      "permit_root_login"       => "no",
      "password_authentication" => "no",
    }
  },

  # sudo cookbook setup: enables passwordless sudo
  "authorization" => {
    "sudo" => {
      "include_sudoers_d" => true,
      "passwordless"      => true,
      "groups"            => [ "sysadmin" ]
    }
  },

  "fail2ban" => {
    "services" => {
      "ssh" => {
        "enabled"  => "true",
        "port"     => "ssh",
        "filter"   => "sshd",
        "maxretry" => "6"
      },
    }
  },

  # uncomplicated firewall (ufw) setup
  "firewall" => {
    "rules" => [
      "ssh"   => { "port" => "22" },
      "http"  => { "port" => "80" },
      "https" => { "port" => "443" },
    ]
  },

  # postgresql password should be set when using knife solo
  "postgresql" => {
    "password" => { "postgres" => SecureRandom.hex(10) }
  },

  "rbenv" => {
    "user_installs" => [{
      "user"   => "deploy",
      "rubies" => [ ruby_version ],
      "gems"   => {
        ruby_version => [{ "name" => "bundler" }]
      }
    }]
  },

})
