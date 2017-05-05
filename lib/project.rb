class Project
  attr_accessor(:name, :leader_id, :date_time, :time)
  attr_reader(:id)

  def initialize(attributes)
    attributes.each do |key, value|
      instance_variable_set("@#{key}", value) unless value.nil?
    end
  end

  def save
    result = DB.exec("INSERT INTO projects (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first()['id'].to_i()
  end

  def == (another_project)
    return self.name() == another_project.name()
  end

  def volunteers
    list_volunteers = []
    project_volunteer_joins = DB.exec("SELECT * FROM project_volunteer_joins WHERE project_id = #{self.id};")
    project_volunteer_joins.each() do |project_volunteer_join|
      id = project_volunteer_join['volunteer_id'].to_i()
      name = Volunteer.find(id).name()
      list_volunteers.push(Volunteer.new({:name => name, :id => id}))
    end
    return list_volunteers
  end

  def not_volunteers
    not_volunteers = []
    all_volunteers = Volunteer.all()
    volunteers = self.volunteers()
    all_volunteers.each() do |volunteer|
      if not volunteers.include?(volunteer)
        not_volunteers.push(volunteer)
      end
    end
    return not_volunteers
  end

  def update_project(name)
    DB.exec("UPDATE projects SET name = '#{name}' WHERE id = #{self.id()};")
  end

  # def update_project_volunteer_joins (attributes)
  #   time = attributes[:time]
  #   attributes.fetch(volunteer_ids, []).each_with_index() do |volunteer_id, time|
  #     DB.exec("INSERT INTO project_volunteer_joins(project_id, volunteer_id, time) VALUES (#{self.id()}, #{volunteer_id.to_i}, #{time(index)})")
  #   end
  # end

  def update_project_volunteer_joins (attributes)
    times = attributes.fetch(:times, [])
    volunteer_ids = attributes.fetch(:volunteer_ids, [])
    volunteer_ids.each_with_index() do |volunteer_id, index|
      DB.exec("INSERT INTO project_volunteer_joins(project_id, volunteer_id, time) VALUES (#{self.id()}, #{volunteer_id.to_i}, #{times(index)})")
    end
  end

  def delete_project
    DB.exec("DELETE FROM projects WHERE id = #{self.id()};")
    DB.exec("DELETE FROM project_volunteer_joins WHERE project_id = #{self.id()};")
  end

  def delete_project_volunteer_joins (volunteer_ids)
    volunteer_ids.each() do |volunteer_id|
      DB.exec("DELETE from project_volunteer_joins where volunteer_id = #{volunteer_id};")
    end
  end

  class << self
    def all
      all_projects = DB.exec('SELECT * FROM projects ORDER BY name;')
      saved_projects = []
      all_projects.each() do |project|
        name = project['name']
        id = project['id'].to_i()
        saved_projects.push(Project.new({:name => name, :id => id}))
      end
      return saved_projects
    end

    def find(id)
      found_project = nil
      Project.all().each() do |project|
        if project.id() == id
          found_project = project
        end
      end
      return found_project
    end
  end
end