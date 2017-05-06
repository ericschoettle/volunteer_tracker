class Leader
  attr_accessor(:name, :total_time)
  attr_reader(:id)

  def initialize (attributes)
    attributes.each do |key, value|
      instance_variable_set("@#{key}", value) unless value.nil?
    end
  end

  def save
    result = DB.exec("INSERT INTO leaders (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first()['id'].to_i()
  end

  def == (another_leader)
    self.name() == another_leader.name()
  end

  def projects
    list_projects = []
    projects = DB.exec("SELECT * FROM projects WHERE leader_id = #{self.id};")
    projects.each do |project|
      id = project['id'].to_i()
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

  def update_leader(name)
    DB.exec("UPDATE leaders SET name = '#{name}' WHERE id = #{self.id()};")
  end

  def update_leader_projects(attributes)
    project_ids = attributes.fetch(:project_ids, [])
    project_ids.each() do |project_id|
      DB.exec("UPDATE projects SET leader_id = '#{self.id()}' WHERE id = #{project_id};")
    end
  end

  def delete_leader_projects()
    DB.exec("UPDATE projects SET leader_id = null WHERE leader_id = #{self.id()};")
  end

  def delete_leader
    DB.exec("DELETE FROM leaders WHERE id = #{self.id()};")
    DB.exec("DELETE FROM projects WHERE leader_id = #{self.id()};")
  end

  class << self
    def all
      all_leaders = DB.exec('SELECT * FROM leaders ORDER BY name;')
      saved_leaders = []
      all_leaders.each() do |leader|
        name = leader['name']
        id = leader['id'].to_i()
        saved_leaders.push(Leader.new({:name => name, :id => id}))
      end
      return saved_leaders
    end

    def find(id)
      found_leader = nil
      Leader.all().each() do |leader|
        if leader.id() == id
          found_leader = leader
        end
      end
      return found_leader
    end
  end
end
