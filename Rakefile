require 'rake'
require 'rake/testtask'

NAME = "napkins"

desc "Run all unit tests"
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/test_*.rb']
  t.verbose = true
end
