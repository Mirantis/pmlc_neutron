require 'spec_helper'
describe 'pmlc_neutron' do

  context 'with defaults for all parameters' do
    it { should contain_class('pmlc_neutron') }
  end
end
