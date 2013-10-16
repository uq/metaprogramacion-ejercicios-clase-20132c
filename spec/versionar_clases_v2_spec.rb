require 'rspec'

class Versionador

  def self.versionar(clase)
    clase.class_eval do
      #self hace referencia a clase
      def version
        @version || 0
      end

      def incrementar_version(cantidad_versiones=1)
        @version = self.version + cantidad_versiones
      end

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