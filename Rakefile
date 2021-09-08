desc 'Look for style guide offenses in your code'
task :rubocop do
  sh 'rubocop --format simple || true'
end

desc 'Run your test suit'
task :spec do
  sh 'rspec'
end

task default: %i[rubocop spec]
