require 'spec_helper'

describe(Volunteer) do
  describe '#name' do
    it('gives the name of the volunteer') do
      volunteer = Helper.make_volunteers()
      expect(volunteer.name()).to eq("bob")
    end
  end

  describe '#id' do
    it('gives ID') do
      volunteer = Helper.make_volunteers()
      expect(volunteer.id()).to be_an_instance_of(Fixnum)
      expect(Volunteer.all()).to eq([volunteer])
    end
  end

  describe '#==' do
    it('is true if volunteers have same name') do
      volunteer1 = Helper.make_volunteers()
      volunteer2 = Helper.make_volunteers()
      expect(volunteer1).to eq(volunteer2)
    end
  end

  describe '#projects' do
    it('returns an array of projects for that volunteer') do
      project, project1 = Helper.make_projects(2)
      volunteer = Helper.make_volunteers()
      volunteer.update_projects_volunteers ([project.id, project1.id])
      expect(volunteer.projects()).to eq([project, project1])
    end
  end

  describe '#delete_volunteer' do
    it "deletes a volunteer from the volunteers database" do
      volunteer = Helper.make_volunteers()
      volunteer.delete_volunteer()
      expect(Volunteer.all()).to eq([])
    end
    it "deletes a volunteer from the projects_volunteers database" do
      volunteer = Helper.make_volunteers()
      project = Helper.make_projects()
      volunteer.update_projects_volunteers([project.id()])
      project_volunteer = Helper.all_projects_volunteers().first()
      expect(project_volunteer["volunteer_id"].to_i()).to eq(volunteer.id())
      volunteer.delete_volunteer()
      expect(Helper.all_projects_volunteers().first()).to eq(nil)
    end
  end
end
