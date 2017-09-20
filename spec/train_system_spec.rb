require 'spec_helper'

describe("#train_system")do
  describe('ckecking train class')do
    it('will create train object')do
      train_test = Train.new({:name => "Choo choo", :city => "Seattle", :time => "09:30:00"})
      expect(train_test.name()).to(eq("Choo choo"))
    end

    it('will store data into database')do
      train_test = Train.new({:name => "Choo choo", :city => "Seattle", :time => "09:30:00"})
      train_test.save()
      id = train_test.id
      train_list = Train.all()
      expect(train_list[0].id).to(eq(id[0]['id']))
    end

  end
end
