require 'rspec'

class Versionador

  def self.versionar(clase)
    clase.send :define_method,:version do
      @version || 0
    end

    clase.send :define_method,:incrementar_version do
      |cantidad_versiones=1|
      @version = self.version + cantidad_versiones
    end
  end

end

class Persona

end

describe 'Versionar clases' do

  it 'versionar clase Persona' do
    Versionador.versionar(Persona)
    persona=Persona.new
    persona.version.should == 0
    persona.incrementar_version
    persona.version.should == 1
    persona.incrementar_version 2
    persona.version.should == 3
  end
end