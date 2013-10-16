require 'rspec'



class Foo
  def nico
    "nico"
  end
end

class String
  def ellipsify(number)
    'hola m...'
  end
end

describe 'Extender strings con ellipsify' do

  it 'extender string' do
    "hola mundo".ellipsify(6).should == "hola m..."
  end

  it 'instanciar nico' do
    foo = Foo.new
    foo.nico.should == 'nico'
    class Foo
      def nico
        "hacer quilombo"
      end
    end
    foo.nico.should == 'hacer quilombo'
  end
end
