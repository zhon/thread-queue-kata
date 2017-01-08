
guard :minitest, test_file_patterns: '*_test.rb' do
  watch(%r|^test/.*_test\.rb|)
  watch(%r|^lib/(.*?)([^/\\]+)\.rb|) { |m|
    "test/#{m[1]}#{m[2]}_test.rb"
  }
  watch(%r|^test/helper\.rb|)        { "test" }
end


# vim: syntax=ruby
