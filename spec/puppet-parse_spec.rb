require 'spec_helper'

describe PuppetParse do

#  subject do
#    run = PuppetParse::Runner.new
#    manifests = [ 'spec/manifests/parameters_rdoc.pp' ]
#    run.run(manifests)
#  end

#  describe '#tests' do

#    let(:manifest) { File.expand_path('./spec/manifests/parameters_rdoc.pp') }

# context "class" do
#   its(:class) { should == Hash }
# end
#

  shared_examples "testing" do 
    subject {
      run = PuppetParse::Runner.new
      manifests = [ './spec/manifests/parameters_rdoc.pp' ]
      run.run(manifests)
    } # subject


    it { should be_a(Hash) }
    it { should_not be_a(Array) }

  end # shared_examples

end # describe Puppetparse
