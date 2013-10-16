require 'rspec'


def romper_ante_nil (instancia)

  instancia.instance_eval do
    def push(obj, *smth)
      raise 'No me mandes un nil' if obj.nil?
      self.class.instance_method(:push).bind(self).call(obj, *smth)
    end

  end

end

describe 'modificar Push de Pila' do

  it 'no rompe cuando le mando otro valor' do
    array = [1]
    array.push(4)
    array.should == [1, 4]
  end

  it 'romper cuando se manda nil a push' do
    array_modificado=[]
    romper_ante_nil array_modificado
    expect { array_modificado.push(nil) }.to raise_error(Exception)
  end


end