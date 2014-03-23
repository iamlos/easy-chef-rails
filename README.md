# Easy Rails Provisioning with Chef

Easily install Rails server environments with Chef.

Benefits:
- really easy to use. It should be easier than Heroku.
- no ssh-ing to the server required
- perfect for new Rails apps.
- based on [Chef](http://www.getchef.com/chef/), the same tool Facebook uses.
It sets you up for unlimited scale.
- no security compromises

### Why this project?

Chef is a great tool. But not everyone has the luxury of spending time to learn
it. Especially when you seemingly get more with `$ git push heroku master`.

This project has a goal of helping you properly set up/provision your server
for deploying Rails apps. It should also make it really easy.

Now, when the time for growth and expansion comes, you know you're ready.

### Usage

**Installation**

Clone this repository:

    $ git clone bruno-/easy-chef-rails your_dir
    $ cd your_dir

Install required ruby gems and Chef cookbooks (cookbooks are Chef libraries):

    $ bundle install
    $ bundle exec berks install   # berkshelf installs chef cookbooks

**Setup**

Add your ssh *public* key to `data_bags/users/deploy.json` file. This is
necessary so you can ssh to your new server later.

    "id": "deploy",
    "ssh_keys": [
      // add your ssh public key and delete this line
      "ssh-rsa AAAAB3Nza..."
    ],
    ...

**Provisioning part**

Buy a server or a VPS, and get its IP address.<br/>
Don't have one? Try [digitalocean](https://www.digitalocean.com/). It's fast
and affordable. (I don't work for digitalocean, I just think they're great)

Install everything to your new server with a single command:

    $ bundle exec knife solo bootstrap root@<server_ip> -r "role[rails]"

Sit back, relax and watch your new server being set up! After it's done, you
can ssh to the server with:

    $ ssh deploy@<server_id>

### Next steps

- now that the server is ready to go, you'll probably want to deploy your app
with [capistrano](http://capistranorb.com/)

Optionally:

- have a look at the project's [source code](roles/rails.rb). It's just an easy
to understand Chef configuration. It has ~80 lines of code - with comments!
- feel free to change, tweak and build upon this base<br/>
Need `mysql` instead of `postgresql`? Just google "chef mysql" and with little
or no effort you should be able to replace postgres with mysql.

### Why should I bother? I can just use Heroku

Heroku is a fantastic service! It has done a development community a great
service by enabling us to deploy apps easily and for free!

There are some downsides though. After some time of using Heroku, you'll start
noticing a few patterns:
- your code and infrastructure will be coupled to Heroku. Big effort will be
required to move the app to some other provider.
- Heroku paid plans are expensive. You'll start wasting time optimizing
your code and infrastructure to always stay free. Example: using in-thread
background jobs, instead of paying Heroku for additional workers.

Depending on a single provider is not good. And you should never waste
time to even further couple your apps to that provider. There should be a
better way.

### Alternatives to this project

- [chef-rails-suite](https://github.com/arrowcircle/chef-rails-suite) - haven't
tried it out, but seems do the same job. It even goes one step further and
configures the app (which is a task maybe better left to capistrano).

- [intercity/chef-repo](https://github.com/intercity/chef-repo) - provisions
server with Chef. Also contains instructions for Capistrano 2.

- [opscode/rails-quick-start](https://github.com/opscode/rails-quick-start) - not
really a beginners guide how to setup multiple-servers Rails infrastructure.

### License

[MIT](LICENSE.md)