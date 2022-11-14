Gem::Specification.new do |s|
    s.name = "monri"
    s.version = Monri::VERSION
    s.required_ruby_version = ">= 2.3.0"
    s.summary = "Ruby bindings for the Monri API"
    s.description = "Your voyage through payment experience starts here. Learn more about how Monri helps to power your business." \
                    "See https://monri.com for details."
    s.author = "Monri"
    s.email = "support@monri.com"
    s.homepage = "https://github.com/MonriPayments/monri-ruby"
    s.license = "MIT"

    s.metadata = {
        "bug_tracker_uri" => "https://github.com/stripe/monri-ruby/issues",
        "changelog_uri" =>
          "https://github.com/MonriPayments/monri-ruby/blob/master/CHANGELOG.md",
        "documentation_uri" => "https://docs.monri.com",
        "github_repo" => "ssh://github.com/MonriPayments/monri-ruby",
        "homepage_uri" => "https://github.com/MonriPayments/monri-ruby",
        "source_code_uri" => "https://github.com/MonriPayments/monri-ruby",
      }

    ignored = Regexp.union(
        /\A\.editorconfig/,
        /\A\.git/,
        /\A\.rubocop/,
        /\A\.travis.yml/,
        /\A\.vscode/,
        /\Atest/
      )
      s.files = `git ls-files`.split("\n").reject { |f| ignored.match(f) }
      s.executables   = `git ls-files -- bin/*`.split("\n")
                                               .map { |f| ::File.basename(f) }
      s.require_paths = ["lib"]
  end