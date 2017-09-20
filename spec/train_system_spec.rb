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
      train_list = Train.all()
      expect(train_list[0].id).to(eq(train_test.id))
    end

    it('will search train using city')do
      train_test1 = Train.new({:name => "Choo choo", :city => "Seattle", :time => "09:30:00"})
      train_test1.save()
      train_test2 = Train.new({:name => "ABC", :city => "redmond", :time => "09:30:00"})
      train_test2.save()
      train_test3 = Train.new({:name => "DEF", :city => "Seattle", :time => "09:30:00"})
      train_test3.save()
      expect(Train.find_train("Seattle")).to(eq([train_test1,train_test3]))
    end

  end
end
