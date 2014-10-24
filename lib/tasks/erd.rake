desc 'Generate Entity Relationship Diagram'

# Generates an ERD from the models contained in the project in an SVG format
# Sourced from https://appcasts.io/blog/creating-a-database-diagram-with-rails-erd

task :generate_erd do
  directory_name = 'docs'
  Dir.mkdir(directory_name) unless File.exists?(directory_name)
  system "erd --inheritance --filename=#{directory_name}/erd --filetype=dot --direct --attributes=foreign_keys,content"
  system "dot -Tsvg #{directory_name}/erd.dot > #{directory_name}/erd.svg"
  File.delete("#{directory_name}/erd.dot")
end

# Automatically runs the ERD generation task above upon each migration and rollback
# Sourced from https://github.com/ctran/annotate_models/wiki

if Rails.env == "development"
  Rake::Task['db:migrate'].enhance do
    Rake::Task['generate_erd'].invoke
  end

  Rake::Task['db:rollback'].enhance do
    Rake::Task['generate_erd'].invoke
  end
end
