
require 'chefspec'  
require_relative '../spec_helper.rb'

describe 'mysql::default' do  
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'installs mysql' do
    expect(chef_run).to install_package('mysql-server')
  end  
end  