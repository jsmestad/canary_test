# CanaryTest

## Installation

    $ gem install canary_test

This is a command-line application, though it could be used inside another Ruby application.

## Configuration

The CLI is configured by passing in a YAML configuration file. There are default
configuration options already set, but you are encouraged to change them.

| option name | default                                                                                       | description                               |
| :--         | :--                                                                                           | :--                                       |
| log_file    | STDOUT                                                                                        | logger output target                      |
| actions     | `['file_creation', 'file_deletion', 'file_modification', 'http_request', 'process_creation']` | list of test actions to perform           |
| http_host   | `www.ruby-lang.org`                                                                           | http host for `http_request` action       |
| http_port   | 80                                                                                            | http port for the `http_request` action   |
| http_data   | `"GET / HTTP/1.0\r\nHost: www.ruby-lang.org\r\n\r\n"`                                                                                          | http data for the `http_request` action   |
| file_path   | {current_directory} + `generated_file.tmp`                                                    | full file path for the `file_\*` actions  |
| process_cmd | `echo "hello world"`                                                                          | command for the `process_creation` action |


An example configuration can be copied from `config/runner.yml`.

## Usage

```bash
canary_test                         # default configuration
canary_test -c ~/my_runner.yml      # with configuration
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

To run the `canary_test` binary in development, use `bundle exec ./exec/canary_test -c config/runner.yml`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jsmestad/canary_test.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
