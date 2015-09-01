require_relative 'three_taps_api'

#r = ThreeTapsAPI::Reference.new
#r.locations 'country'

class ATest
  attr_accessor :a, :b, :c

  def create_getter_and_setter(name)
    get = Proc.new { instance_variable_get "@#{name}" }
    set = Proc.new { |val| instance_variable_set "@#{name}", val }
    self.class.send :define_method, "#{name}", get
    self.class.send :define_method, "#{name}=", set
  end

  def initialize(opts = {})
    opts.each do |k,v|
      self.send "#{k.to_s}=", v
    end
  end

  def method_missing(name, *args, &block)
    name = name.to_s.chop if name.to_s.reverse[0] == '='
    create_getter_and_setter name
    self.send "#{name}=", args[0]
  end
end

#a = ATest.new({ a: 1, b: 2, c: 3 })
#p a.a
#p a.b
#p a.c
#a.d = 4
#p a.d
#
class BTest
  def initialize(args)
    args.each do |k, v|
      p = Proc.new { instance_variable_get "@#{k}" }
      p2 = Proc.new { |val| instance_variable_set "@#{k}", val }
      self.class.send(:define_method, "#{k}", p)
      self.class.send(:define_method, "#{k}=", p2)

      self.send "#{k.to_s}=".to_sym, v
    end
  end
end

#p BTest.new({ a: 1, b: 2 }).a


#s = ThreeTapsAPI::Search.new({ category_group: 'AAAA', location: { zipcode: 92001 } })
#s.category_group = 'BBBB'
#p s.location.zipcode
#s.location.zipcode = 11111
#p s.location.zipcode
#s.category = 'animals'
#p s
#s.category_group.must_equal 'AAAA'
#s.must_respond_to 'category_group='
#s.location.zipcode.must_equal 92001
#s.location.must_respond_to 'zipcode='
#s.category = 'Animals'
#s.category.must_equal 'Animals'
#s.must_respond_to :category=

module GetSetModule
  def create_getter_and_setter(name)
    get = Proc.new { instance_variable_get "@#{name}" }
    set = Proc.new { |val| instance_variable_set "@#{name}", val; @parameters[name.to_sym] = val }
    self.class.send :define_method, "#{name}", get
    self.class.send :define_method, "#{name}=", set
  end
end

class ADynamicGetSetClass
  extend GetSetModule

  def method_missing(name, *args)
    name = name.to_s.chop if name.to_s.reverse[0] == '='
    create_getter_and_setter name
    self.send "#{name.to_s}=", args[0]
  end
end

adgsc = ADynamicGetSetClass.new
#adgsc.a = 10

a = ThreeTapsAPI::Search.new
a.radius = 5
a.search
p a.postings

r = ThreeTapsAPI::Reference.new
#r.categories
