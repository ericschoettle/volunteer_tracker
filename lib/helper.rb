class Helper
  def self.clear_db
    DB.exec("DELETE FROM volunteers *;")
    DB.exec("DELETE FROM projects *;")
  end

  def self.all_project_volunteer_joins
    DB.exec("SELECT * FROM project_volunteer_joins;")
  end
end
