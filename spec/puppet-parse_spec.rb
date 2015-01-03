require 'spec_helper'

def setup(file)
  run = PuppetParse::Runner.new
  manifests = [ file ]
  run.run(manifests)
end

shared_examples "standard tests" do |file, klass|

  subject { setup(file) }

  it 'should be a hash' do
    subject.should be_a(Hash)
  end

  it 'class should have a name' do
    subject.class.should_not be nil
  end

  it 'parameters and docs keys should be set' do
    subject[klass].keys.should =~ ['parameters', 'docs']
  end
  
  it 'parameters should be a hash' do
    subject[klass]['parameters'].should be_a(Hash)
  end

  it 'docs should be a hash' do
    subject[klass]['docs'].should be_a(Hash)
  end

  it 'values should not be nil' do
    subject[klass].values.should_not include(nil)
  end

end

shared_examples "parameters" do |file, klass|
  subject { setup(file) }
  it 'parameters should have four keys' do
    expect(subject[klass]['parameters'].keys.size).to eq(4)
  end
end

shared_examples "no parameters" do |file, klass|
  subject { setup(file) }
  it 'parameters should have no keys' do
    expect(subject[klass]['parameters'].keys.size).to eq(0)
  end
end

shared_examples "rdoc" do |file, klass|
  subject { setup(file) }
  it 'docs should have one key' do
    expect(subject[klass]['docs'].keys.size).to eq(1)
  end
end

shared_examples "no rdoc" do |file, klass|
  subject { setup(file) }
  it 'docs should have no keys' do
    expect(subject[klass]['docs'].keys.size).to eq(0)
  end
end


describe "manifest with parameters and rdoc" do
    file = 'spec/manifests/parameters_rdoc.pp'
    klass = 'parameters_rdoc'
    it_should_behave_like "standard tests", file, klass
    it_should_behave_like "parameters", file, klass
    it_should_behave_like "rdoc", file, klass    
end 

describe "manifest with parameters and no rdoc" do
    file = 'spec/manifests/parameters_nordoc.pp'
    klass = 'parameters_nordoc'
    it_should_behave_like "standard tests", file, klass
    it_should_behave_like "parameters", file, klass
    it_should_behave_like "no rdoc", file, klass        
end 

describe "manifest with no parameters and rdoc" do
    file = 'spec/manifests/noparameters_rdoc.pp'
    klass = 'noparameters_rdoc'
    it_should_behave_like "standard tests", file, klass
    it_should_behave_like "no parameters", file, klass
    it_should_behave_like "rdoc", file, klass    
end 

describe "manifest with no parameters and no rdoc" do
    file = 'spec/manifests/noparameters_nordoc.pp'
    klass = 'noparameters_nordoc'
    it_should_behave_like "standard tests", file, klass
    it_should_behave_like "no parameters", file, klass
    it_should_behave_like "no rdoc", file, klass        
end 

describe "define with rdoc" do
  file = 'spec/manifests/define_rdoc.pp'
  klass = 'define_rdoc'
  it_should_behave_like "standard tests", file, klass
  it_should_behave_like "rdoc", file, klass    
end

describe "define with no rdoc" do
  file = 'spec/manifests/define_nordoc.pp'
  klass = 'define_nordoc'
  it_should_behave_like "standard tests", file, klass
  it_should_behave_like "no rdoc", file, klass    
end

describe "noclass" do
  file = 'spec/manifests/noclass.pp'
  subject { setup(file) }
  
  it 'should be a hash' do
    subject.should be_a(Hash)
  end
  
end

describe "parameter with array" do
  file = 'spec/manifests/array_parameters.pp'
  subject { setup(file) }

  it 'parameters param_one should be an array' do
    subject['array_parameters']['parameters']['param_one'].should be_a(Array)
    expect(subject['array_parameters']['parameters']['param_one'].size).to eq(2)
  end

end
