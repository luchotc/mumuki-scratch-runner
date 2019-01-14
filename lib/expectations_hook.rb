class ScratchExpectationsHook < Mumukit::Templates::MulangExpectationsHook
  include_smells true

  def language
    'Mulang'
  end

  def mulang_code(request)
    ast, _ = request.result
    Mulang::Code.new(mulang_language, ast)
  end

  def default_smell_exceptions
    LOGIC_SMELLS + FUNCTIONAL_SMELLS + OBJECT_ORIENTED_SMELLS + EXPRESSIVENESS_SMELLS
  end
end
