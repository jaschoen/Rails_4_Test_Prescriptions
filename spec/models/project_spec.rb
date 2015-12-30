require 'rails_helper' # contains rails setup common to all tests

RSpec.describe Project do #describe defines the suite of tests that share a common setup
	describe "initialization" do
		let(:project) {Project.new}
		let(:task) {Task.new}

		it "considers a project with no test to be done" do
			expect(project).to be_done
		end

		it "knows that a project with an incomplete task is not done" do
			project.tasks << task
			expect(project).not_to be_done
		end

		it "marks a project done if it's tasks are done" do 
			project.tasks << task
			task.mark_completed
			expect(project).to be_done
		end
	end

	describe "estimates" do
		let(:project) {Project.new}
		let(:done) {Task.new(size: 2, completed: true)}		
		let(:small_not_done) {Task.new(size: 1)}
		let(:large_not_done) {Task.new(size: 4)}

		before(:example) do
			project.tasks = [done, small_not_done, large_not_done]
		end

		it "can calculate total size" do 
			expect(project.total_size).to eq(7)
		end

		it "can calculate remaining size" do 
			expect(project.remaining_size).to eq(5)
		end
	end

end
