require 'spec_helper'

describe(Project) do
  describe '#name' do
    it('gives the name of the project') do
      test_project = Project.new({:name => "polar express"})
      expect(test_project.name()).to eq("polar express")
    end
  end

  describe '#id and #save' do
    it('saves and gives ID') do
      test_project = Project.new({:name => "polar express"})
      test_project.save()
      expect(test_project.id()).to be_an_instance_of(Fixnum)
      expect(Project.all()).to eq([test_project])
    end
  end

  describe '#==' do
    it('is true if projects have same name') do
      project1 = Project.new({:name => "polar express"})
      project2 = Project.new({:name => "polar express"})
      expect(project1).to eq(project2)
    end
  end

  describe '#==' do
    it('is true if projects have same name') do
      project1 = Project.new({:name => "polar express"})
      project2 = Project.new({:name => "polar express"})
      expect(project1).to eq(project2)
    end
  end

  describe '.find' do
    it('returns a project by its ID') do
      project1 = Project.new({:name => "polar express"})
      project1.save()
      project2 = Project.new({:name => "project2"})
      project2.save()
      expect(Project.find(project2.id())).to eq(project2)
    end
  end

  describe '#volunteers' do
    it('returns an array of volunteers for that project') do
      project = Project.new({:name => "polar express"})
      project.save()
      volunteer = Volunteer.new({:name => "Toronto"})
      volunteer.save()
      volunteer1 = Volunteer.new({:name => "Omaha"})
      volunteer1.save()
      project.update_project_volunteer_joins ([volunteer.id, volunteer1.id])
      expect(project.volunteers()).to eq([volunteer, volunteer1])
    end
  end
  describe '#update_project' do
    it "lets you update projects in the database" do
      project = Project.new({:name => "polar express"})
      project.save()
      project.update_project("thomas")
      project = Project.find(project.id())
      expect(project.name()).to(eq("thomas"))
    end
  end

  describe '#delete_project' do
    it "deletes a project from projects database" do
      project = Project.new({:name => "polar express"})
      project.save()
      project.delete_project()
      expect(Project.all()).to eq([])
    end
    it "deletes a project from project_volunteer_joins database" do
      project = Project.new({:name => "polar express"})
      project.save()
      volunteer = Volunteer.new({:name => "Seattle"})
      volunteer.save()
      project.update_project_volunteer_joins([volunteer.id()])
      project_volunteer_join = Helper.all_project_volunteer_joins().first()
      expect(project_volunteer_join["project_id"].to_i()).to eq(project.id())
      project.delete_project()
      expect(Helper.all_project_volunteer_joins().first()).to eq(nil)
    end
  end

  describe '#update_project_volunteer_joins' do
    it "creates join rows to connect volunteers and a project" do
      project = Project.new({:name => "polar express"})
      project.save()
      volunteer = Volunteer.new({:name => "Toronto"})
      volunteer.save()
      volunteer1 = Volunteer.new({:name => "Omaha"})
      volunteer1.save()
      project.update_project_volunteer_joins([volunteer1.id(), volunteer.id()])
      expect(project.volunteers()).to eq([volunteer1, volunteer])
    end
  end

  describe '#not_volunteers' do
    it "shows volunteers that are not assigned to the project" do
      project = Project.new({:name => "polar express"})
      project.save()
      volunteer = Volunteer.new({:name => "Toronto"})
      volunteer.save()
      volunteer1 = Volunteer.new({:name => "Omaha"})
      volunteer1.save()
      project.update_project_volunteer_joins([volunteer1.id()])
      expect(project.not_volunteers()).to eq([volunteer])
    end
  end
end
