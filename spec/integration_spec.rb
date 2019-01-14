require 'active_support/all'
require 'mumukit/bridge'

describe 'Server' do

  let(:bridge) { Mumukit::Bridge::Runner.new('http://localhost:4568') }

  before(:all) do
    @pid = Process.spawn 'rackup -p 4568', err: '/dev/null'
    sleep 8
  end

  after(:all) { Process.kill 'TERM', @pid }


  it 'answers a valid hash when submission passes' do
    response = bridge.run_tests!(test: nil, extra: '',
                                 content: file_fixture("ast_looks.json"),
                                 expectations: [])

    expect(response[:status]).to eq :passed
    expect(response[:test_results].size).to eq 0
    expect(response[:response_type]).to eq :unstructured
  end
end
