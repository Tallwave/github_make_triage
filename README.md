# GitHub Triage Project Maker

[![Circle CI](https://circleci.com/gh/Tallwave/github_make_triage.svg?style=shield&circle-token=:circle-token)](https://circleci.com/gh/Tallwave/github_make_triage) [![Code Climate](https://codeclimate.com/github/Tallwave/github_make_triage/badges/gpa.svg)](https://codeclimate.com/github/Tallwave/github_make_triage)

Bug management requires some kind of system. GitHub has a nifty Projects feature that allows you to move issues as cards across columns. Kinda like [Kanban](http://kanbanblog.com/explained/). The catch is that for every repository you have to start from scratch to get all of the columns set up. This is a simple script to automate that process in The Tallwave Way. You get the following columns:

* Received
* Triaged
* Scheduled
* In Progress
* Ready for Test
* Testing
* Ready to Deploy
* Done

This may not be Your Process, and that's ok. Right now those are hardcoded, but at some point, we might make this configurable. Of course, patches welcome too. :)

## Installation
GitHub Triage Project Maker is built with Ruby and needs Ruby 2.0 or higher. Install it with RubyGems.

```
gem install github_make_triage
```

Some environments may require `sudo` permissions.

```
sudo gem install github_make_triage
```

## Usage
There is an executable `make-triage-project` available. It takes 3 parameters:

1. The owner of the repository (individual or organization)
2. The name of the repository
3. An access token in order to access the GitHub API. You can generate this token from [here](https://github.com/settings/tokens), and clicking on "Generate new token". Here's a [blog post with some more of the details involved](http://blog.swilliams.me/words/2015/04/01/two-factor-authentication-for-github/).

To add the Bug Tracking Project to this repository, you would use:

```
> make-triage-project tallwave github_issue_exporter [TOKEN]
```

## Contributing

 * Fork
 * Create a branch for your feature
 * Make it better
 * Create a Pull Request
