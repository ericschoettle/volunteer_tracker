require 'spec_helper'

describe(Project) do
  describe '#name' do
    it('gives the name of the project') do
      project = Helper.make_projects()
      expect(project.name()).to eq("Plant trees")
    end
  end

  describe '#leader' do
    it "returns the leader of the project" do
      project = Helper.make_projects()
      leader = Helper.make_leaders()
      project.add_leader(leader)
      expect(project.leader()).to eq(leader)
    end
  end

  describe '#id and #save' do
    it('saves and gives ID') do
      project = Helper.make_projects()
      expect(project.id()).to be_an_instance_of(Fixnum)
      expect(Project.all()).to eq([project])
    end
  end

  describe '#==' do
    it('is true if projects have same name') do
      project1 = Helper.make_projects()
      project2 = Helper.make_projects()
      expect(project1).to eq(project2)
    end
  end

  describe '.find' do
    it('returns a project by its ID') do
      project1, project2 = Helper.make_projects(2)
      expect(Project.find(project2.id())).to eq(project2)
    end
  end

  describe '#volunteers' do
    it('returns an array of volunteers for that project') do
      project = Helper.make_projects()
      volunteer0, volunteer1 = Helper.make_volunteers(2)
      project.update_projects_volunteers ({:volunteer_ids => [volunteer0.id, volunteer1.id]})
      expect(project.volunteers()).to eq([volunteer0, volunteer1])
    end
  end

  describe '#not_volunteers' do
    it "shows volunteers that are not assigned to the project" do
      project = Helper.make_projects()
      volunteer1, volunteer2 = Helper.make_volunteers(2)
      project.update_projects_volunteers({:volunteer_ids => [volunteer1.id()]})
      expect(project.not_volunteers()).to eq([volunteer2])
    end
  end

  describe '#add_leader' do
    it "lets you add a leader to a project" do
      project = Helper.make_projects()
      leader = Helper.make_leaders()
      project.add_leader(leader)
      expect(project.leader_id).to(eq(leader.id()))
    end
  end

  describe '#update_projects_volunteers' do
    it "creates join rows to connect volunteers and a project" do
      project = Helper.make_projects()
      volunteer1, volunteer2 = Helper.make_volunteers(2)
      project.update_projects_volunteers({:volunteer_ids => [volunteer1.id(), volunteer2.id()]})
      expect(project.volunteers()).to eq([volunteer1, volunteer2])
    end
  end

  describe '#delete_leader' do
    it "lets you delete a leader from a project" do
      project = Helper.make_projects()
      leader = Helper.make_leaders()
      project.add_leader(leader)
      project.delete_leader()
      expect(project.leader_id).to(eq(nil))
    end
  end

  describe '#delete_project' do
    it "deletes a project from projects database" do
      project = Helper.make_projects()
      project.delete_project()
      expect(Project.all()).to eq([])
    end
    it "deletes a project from projects_volunteers database" do
      project = Helper.make_projects()
      volunteer = Helper.make_volunteers()
      project.update_projects_volunteers({:volunteer_ids => [volunteer.id()]})
      project_volunteer = Helper.all_projects_volunteers().first()
      expect(project_volunteer["project_id"].to_i()).to eq(project.id())
      project.delete_project()
      expect(Helper.all_projects_volunteers().first()).to eq(nil)
    end
  end
end
