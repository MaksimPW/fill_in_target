require 'rake'

describe 'target namespace rake task' do
  describe 'target:fill_in_target' do
    before do
      load File.expand_path("./../../tasks/target.rake", __FILE__)
      Rake::Task.define_task(:environment)
    end

    it "should bake a bar" do
      Rake::Task["target:fill_in_target"].invoke
    end
  end
end