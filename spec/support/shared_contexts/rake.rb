# frozen_string_literal: true

require "rake"

shared_context "rake" do
  let(:rake)      { Rake::Application.new }
  let(:task_name) { "generate_#{self.class.top_level_description}" }
  let(:task_path) { "/tasks/generate_contributor_covenant" }
  subject         { rake[task_name] }

  def loaded_files_excluding_current_rake_file
    $LOADED_FEATURES.reject { |file| file == [ContributorCovenant.root].join("#{task_path}.rake").to_s }
  end

  before do
    Rake.application = rake
    Rake.application.rake_require(task_path, [ContributorCovenant.root.to_s], loaded_files_excluding_current_rake_file)

    Rake::Task.define_task(:environment)
  end
end
