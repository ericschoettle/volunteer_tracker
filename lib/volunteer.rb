class Volunteer
  attr_accessor(:name, :total_time)
  attr_reader(:id)

  def initialize(attributes)
    attributes.each do |key, value|
      instance_variable_set("@#{key}", value) unless value.nil?
    end
  end

  def save
    result = DB.exec("INSERT INTO volunteers (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first()['id'].to_i()
  end

  def ==(another_volunteer)
    return self.name() == another_volunteer.name()
  end

  def projects
    list_projects = []
    projects_volunteers = DB.exec("SELECT * FROM projects_volunteers WHERE volunteer_id = #{self.id};")
    projects_volunteers.each() do |project_volunteer|
      id = project_volunteer['project_id'].to_i()
      name = Project.find(id).name()
      list_projects.push(Project.new({:name => name, :id => id}))
    end
    return list_projects
  end

  def not_projects
    not_projects = []
    all_projects = Project.all()
    projects = self.projects()
    all_projects.each() do |project|
      if not projects.include?(project)
        not_projects.push(project)
      end
    end
    return not_projects
  end

  def update_volunteer(name)
    DB.exec("UPDATE volunteers SET name = '#{name}' WHERE id = #{self.id()};")
  end

  def update_projects_volunteers (project_ids)
    project_ids.each() do |project_id|
      DB.exec("INSERT INTO projects_volunteers (project_id, volunteer_id) VALUES (#{project_id}, #{self.id()})")
    end
  end

  def delete_volunteer
    DB.exec("DELETE FROM volunteers WHERE id = #{self.id()};")
    DB.exec("DELETE FROM projects_volunteers WHERE volunteer_id = #{self.id()};")
  end

  def delete_projects_volunteers(project_ids)
    project_ids.each() do |project_id|
      DB.exec("DELETE FROM projects_volunteers WHERE project_id = #{project_id};")
    end
  end

  class << self
    def all
      all_volunteers = DB.exec('SELECT * FROM volunteers ORDER BY name;')
      saved_volunteers = []
      all_volunteers.each() do |volunteer|
        name = volunteer['name']
        id = volunteer['id'].to_i()
        saved_volunteers.push(Volunteer.new({:name => name, :id => id}))
      end
      return saved_volunteers
    end

    def find(id)
      found_volunteer = nil
      Volunteer.all().each() do |volunteer|
        if volunteer.id() == id
          found_volunteer = volunteer
        end
      end
      return found_volunteer
    end
  end
end
