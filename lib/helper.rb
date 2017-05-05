class Helper
  def self.clear_db
    DB.exec("DELETE FROM volunteers *;")
    DB.exec("DELETE FROM projects *;")
  end

  def self.all_projects_volunteers
    DB.exec("SELECT * FROM projects_volunteers;")
  end
end
