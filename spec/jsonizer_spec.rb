require 'rspec'

class String
  def formatear_json
    '"'+self+'"'
  end
end

class Numeric
  def formatear_json
    self.to_s
  end
end

class Object
  def formatear_json
    '{'+self.formatear_atributos_json+'}'
  end

  def formatear_atributos_json
    self.instance_variables.map{
      |variable|
      variable.to_s[1..-1].formatear_json+':'+self.
          instance_variable_get(variable).formatear_json
    }.join(',')
  end
end

class Array
  def formatear_json
    '['+self.formatear_elementos_json+']'
  end

  def formatear_elementos_json
    self.map{
      |elemento| elemento.formatear_json
    }.join(',')
  end
end

describe 'jsonizer' do

  describe 'formatear string a json' do
    it 'convierto hola a valor json' do
      'hola'.formatear_json.should == '"hola"'
    end
  end

  describe 'formatear numero a json' do
    it 'convierto 42 a valor json' do
      42.formatear_json.should == '42'
    end

    it 'convierto 42.4 a valor json' do
      42.4.formatear_json.should == '42.4'
    end

  end

  describe 'formatear estructura a json' do
    it 'formatear estructura vacia' do
      class PersonaVacia
      end
      PersonaVacia.new.formatear_json.should == '{}'
    end

    it 'formatear estructura con un atributo primitivo' do
      class PersonaAtributoPrimitivo
        def initialize
          @nombre ='Foo'
        end
      end
      PersonaAtributoPrimitivo.new.formatear_json.should ==
          '{"nombre":"Foo"}'
    end

    it 'formatear estructura con recursion' do
      class PersonaConPadre
        def initialize
          @nombre ='Foo Jr.'
          @padre = PersonaAtributoPrimitivo.new
        end
      end
      PersonaConPadre.new.formatear_json.should ==
          '{"nombre":"Foo Jr.","padre":{"nombre":"Foo"}}'
    end
  end

  describe 'formatear listas a json' do
    it 'formatear lista vacia' do
      [].formatear_json.should == '[]'
    end

    it 'formatear lista con numeros' do
      [2,4,6,7].formatear_json.should == '[2,4,6,7]'
    end
  end

  describe 'formatear nil como json' do
    it 'formatear valor nil como json' do
      nil.formatear_json.should == '{}'
    end
  end

end
