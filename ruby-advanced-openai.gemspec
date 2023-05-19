require_relative "lib/openai/version"

Gem::Specification.new do |spec|
  spec.name          = "ruby-advanced-openai"
  spec.version       = OpenAI::VERSION
  spec.authors       = ["Yudai-hub"]
  spec.email         = ["coffeecoffee@outlook.jp"]

  spec.summary       = "Advanced OpenAI API wrapper for Ruby."
  spec.homepage      = "https://github.com/Yudai-hub/ruby-advanced-openai"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.6.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Yudai-hub/ruby-advanced-openai"
  spec.metadata["changelog_uri"] = "https://github.com/Yudai-hub/ruby-advanced-openai/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", ">= 1"
  spec.add_dependency "faraday-multipart", ">= 1"
end
