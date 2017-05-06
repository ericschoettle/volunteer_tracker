require 'spec_helper'

describe Leader do
  describe '#name' do
    it('gives the name of the leader') do
      leader = Helper.make_leaders()
      expect(leader.name()).to eq("Aaron")
    end
  end

  describe '#id and #save' do
    it('saves and gives ID') do
      leader = Helper.make_leaders()
      expect(leader.id()).to be_an_instance_of(Fixnum)
      expect(Leader.all()).to eq([leader])
    end
  end

  describe '#==' do
    it('is true if leaders have same name') do
      leader1 = Helper.make_leaders()
      leader2 = Helper.make_leaders()
      expect(leader1).to eq(leader2)
    end
  end

  describe '.find' do
    it('returns a leader by its ID') do
      leader1, leader2 = Helper.make_leaders(2)
      expect(Leader.find(leader2.id())).to eq(leader2)
    end
  end

  describe '#update_leader' do
    it "lets you update leaders in the database" do
      leader = Helper.make_leaders()
      leader.update_leader("thomas")
      leader = Leader.find(leader.id())
      expect(leader.name()).to(eq("thomas"))
    end
  end

  describe '#delete_leader' do
    it "deletes a leader from leaders database" do
      leader = Helper.make_leaders()
      leader.delete_leader()
      expect(Leader.all()).to eq([])
    end
  end

  describe '#projects' do
    it('returns an array of projects for that leader') do
      leader = Helper.make_leaders()
      project0, project1 = Helper.make_projects(2)
      leader.update_leader_projects ({:project_ids => [project0.id, project1.id]})
      expect(leader.projects()).to eq([project0, project1])
    end
  end

  describe '#delete_leader_projects' do
    it "lets you delete leaders from a project" do
      leader = Helper.make_leaders()
      project = Helper.make_projects()
      project.add_leader(leader)
      project = Project.find(project.id())
      expect(project.leader_id()).to(eq(leader.id()))
      leader.delete_leader_projects()
      project = Project.find(project.id())
      expect(project.leader_id).to(eq(0))
    end
  end

  describe '#not_projects' do
    it "shows projects that are not assigned to the project" do
      leader = Helper.make_leaders()
      project1, project2 = Helper.make_projects(2)
      leader.update_leader_projects({:project_ids => [project1.id()]})
      expect(leader.not_projects()).to eq([project2])
    end
  end
end
