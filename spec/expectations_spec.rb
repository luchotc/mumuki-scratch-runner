require_relative 'spec_helper'

describe ScratchExpectationsHook do
  def req(expectations, content)
    ScratchPrecompileHook.new.compile(
      OpenStruct.new(expectations: expectations, content: content))
  end

  def compile_and_run(request)
    runner.run!(runner.compile(request))
  end

  let(:runner) { ScratchExpectationsHook.new(mulang_path: './bin/mulang') }
  let(:result) { compile_and_run(req(expectations, code)) }

  context 'basic expectations' do
    let(:code) { file_fixture("ast_looks.json") }
    let(:expectations) do
      [{binding: 'Sprite1', inspection: 'Uses:sayforsecs'},
       {binding: 'Sprite1', inspection: 'Uses:If'}]
    end

    it { expect(result).to eq([{expectation: expectations[0], result: true},
                               {expectation: expectations[1], result: false}]) }
  end
end
