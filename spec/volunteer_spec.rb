require 'spec_helper'

describe(Volunteer) do
  describe '#name' do
    it('gives the name of the volunteer') do
      test_volunteer = Volunteer.new({:name => "Toronto"})
      expect(test_volunteer.name()).to eq("Toronto")
    end
  end

  describe '#id and #save' do
    it('saves and gives ID') do
      test_volunteer = Volunteer.new({:name => "Toronto"})
      test_volunteer.save()
      expect(test_volunteer.id()).to be_an_instance_of(Fixnum)
      expect(Volunteer.all()).to eq([test_volunteer])
    end
  end

  describe '#==' do
    it('is true if volunteers have same name') do
      volunteer1 = Volunteer.new({:name => "Toronto"})
      volunteer2 = Volunteer.new({:name => "Toronto"})
      expect(volunteer1).to eq(volunteer2)
    end
  end

  describe '#projects' do
    it('returns an array of projects for that volunteer') do
      project = Project.new({:name => "polar express"})
      project.save()
      project1 = Project.new({:name => "pineapple express"})
      project1.save()
      volunteer = Volunteer.new({:name => "Toronto"})
      volunteer.save()
      volunteer.update_projects_volunteers ([project.id, project1.id])
      expect(volunteer.projects()).to eq([project, project1])
    end
  end

  describe '#delete_volunteer' do
    it "deletes a volunteer from the volunteers database" do
      volunteer = Volunteer.new({:name => "Seattle"})
      volunteer.save()
      volunteer.delete_volunteer()
      expect(Volunteer.all()).to eq([])
    end
    it "deletes a volunteer from the projects_volunteers database" do
      volunteer = Volunteer.new({:name => "Seattle"})
      volunteer.save()
      project = Project.new({:name => "polar express"})
      project.save()
      volunteer.update_projects_volunteers([project.id()])
      project_volunteer = Helper.all_projects_volunteers().first()
      expect(project_volunteer["volunteer_id"].to_i()).to eq(volunteer.id())
      volunteer.delete_volunteer()
      expect(Helper.all_projects_volunteers().first()).to eq(nil)
    end
  end
end
