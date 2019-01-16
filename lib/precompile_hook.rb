class ScratchPrecompileHook < Mumukit::Templates::FileHook
  attr_accessor :batch

  DEFAULT_TIMEOUT = 2

  structured true
  isolated true

  def tempfile_extension
    '.json'
  end

  def command_line(filename)
    "mulang-scratch #{filename} #{locale_argument} #{timeout_argument}"
  end

  def locale_argument
    "--language #{@locale}" if @locale
  end

  def timeout_argument
    "--timeout " + timeout.to_s
  end

  def timeout
    (ENV['MUMUKI_SCRATCH_TIMEOUT'] || DEFAULT_TIMEOUT).to_i * 1000
  end

  def compile(request)
    @locale = request[:locale]
    file = super request

    struct request.to_h.merge batch: @batch,
                              result: run!(file)
  end

  def compile_file_content(request)
    @batch = Scratch::BatchParser.parse(request)
    @batch.to_json
  end

  private
end
