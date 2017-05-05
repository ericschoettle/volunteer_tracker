class Leader
  attr_accessor(:name)
  attr_reader(:id)

  def initialize (attributes)
    attributes.each do |key, value|
      instance_variable_set("@#{key}", value) unless vaule.nil?
    end
  end

  def save
    result = DB.exec("INSERT INTO projects (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first()['id'].to_i()
  end

  def == (another_leader)
    self.name() == another_project.name()
  end

  def projects
    list_projects = []
    projects = DB.exec("SELECT * FROM projects WHERE leader_id = #{self.id};")
    projects.each do |project|
      id = project['id'].to_i()
      name = Project.find(id).name()
      list_projects.push(Project.new({:name => name, :id => id}))
      saved_pro

end
