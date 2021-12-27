class Volunteer
  attr_accessor :id, :project_id, :name

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
    @project_id = attributes[:project_id]
  end

end