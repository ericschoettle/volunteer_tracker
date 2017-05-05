class Helper
  def self.clear_db
    DB.exec("DELETE FROM volunteers *;")
    DB.exec("DELETE FROM projects *;")
    DB.exec("DELETE FROM projects_volunteers *;")
    DB.exec("DELETE FROM leaders *;")
  end

  def self.all_projects_volunteers
    DB.exec("SELECT * FROM projects_volunteers;")
  end

  def self.make_volunteers (number = 1)
    names = ["bob", "Sally", "Jose"]
    volunteers = []
    names[0..(number-1)].each do |name|
      volunteer = Volunteer.new({:name => name})
      volunteer.save()
      volunteers << (volunteer)
    end
    if volunteers.length == 1
      volunteers = volunteers[0]
    end
    return volunteers
  end

  def self.make_leaders (number = 1)
    names = ["Aaron", "Martha", "Margaret"]
    leaders = []
    names[0..(number-1)].each do |name|
      leader = Leader.new({:name => name})
      leader.save()
      leaders << (leader)
    end
    if leaders.length == 1
      leaders = leaders[0]
    end
    return leaders
  end

  def self.make_projects (number = 1)
    names = ["Plant trees", "Hold Fundraiser", "Do good"]
    projects = []
    names[0..(number-1)].each do |name|
      project = Project.new({:name => name})
      project.save()
      projects << (project)
    end
    if projects.length == 1
      projects = projects[0]
    end
    return projects
  end
end
