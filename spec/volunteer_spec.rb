require('spec_helper')

describe '#Volunteer' do
  describe('#name') do
    it("returns the name of the volunteer") do
      test_volunteer = Volunteer.new({name: 'Jane', project_id: 1, id: nil})
      expect(test_volunteer.name).to(eq('Jane'))
    end
  end

  describe('#project_id') do
    it('returns the project_id of the volunteer') do
      test_volunteer = Volunteer.new({name: 'Jane', project_id: 1, id: nil})
      expect(test_volunteer.project_id).to(eq(1))
    end
  end

  describe('#==') do
    it('checks for equality based on the name of a volunteer') do
      volunteer1 = Volunteer.new({name: 'Jane', project_id: 1, id: nil})
      volunteer2 = Volunteer.new({name: 'Jane', project_id: 1, id: nil})
      expect(volunteer1 == volunteer2).to(eq(true))
    end
  end

  context('.all') do
    it('is empty to start') do
      expect(Volunteer.all).to(eq([]))
    end

    it('returns all volunteers') do
      volunteer1 = Volunteer.new({name: 'Jane', project_id: 1, id: nil})
      volunteer1.save
      volunteer2 = Volunteer.new({name: 'Joe', project_id: 1, id: nil})
      volunteer2.save
      expect(Volunteer.all).to(eq([volunteer1, volunteer2]))
    end
  end

  describe('#save') do
    it('adds a volunteer to the database') do
      volunteer1 = Volunteer.new({name: 'Jane', project_id: 1, id: nil})
      volunteer1.save
      expect(Volunteer.all).to(eq([volunteer1]))
    end
  end

  describe('.find') do
    it('returns a volunteer by id') do
      volunteer1 = Volunteer.new({name: 'Jane', project_id: 1, id: nil})
      volunteer1.save
      volunteer2 = Volunteer.new({name: 'Joe', project_id: 1, id: nil})
      volunteer2.save
      expect(Volunteer.find(volunteer1.id)).to(eq(volunteer1))
    end
  end

  describe('.clear') do
    it('clears the database of all volunteers') do
      volunteer1 = Volunteer.new({name: 'Jane', project_id: 1, id: nil})
      volunteer1.save
      volunteer2 = Volunteer.new({name: 'Joe', project_id: 1, id: nil})
      volunteer2.save
      Volunteer.clear
      expect(Volunteer.all).to(eq([]))
    end
  end

  describe('.find_by_project') do
    it('returns all volunteers assigned to a specific project') do
      project = Project.new({title: 'Teaching Kids to Code', id: nil})
      project.save
      volunteer1 = Volunteer.new({name: 'Jasmine', project_id: project.id, id: nil})
      volunteer1.save
      volunteer2 = Volunteer.new({name: 'Joe', project_id: project.id, id: nil})
      volunteer2.save
      expect(Volunteer.find_by_project(project.id)).to(eq([volunteer1, volunteer2]))
    end
  end

  describe('#update') do
    it('allows the user to update a volunteer') do
      volunteer1 = Volunteer.new({name: 'Jane', project_id: 1, id: nil})
      volunteer1.save
      volunteer1.update({name: 'Joe'})
      expect(volunteer1.name).to(eq('Joe'))
    end
  end

  describe('#delete') do
    it('allows the user to remove a volunteer') do
      volunteer1 = Volunteer.new({name: 'Jane', project_id: 1, id: nil})
      volunteer1.save
      volunteer1.delete
      expect(Volunteer.all).to(eq([]))
    end
  end

end