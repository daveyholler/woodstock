class ThemeToggleComponent < ViewComponent::Base
  def initialize(class: nil)
    @class = binding.local_variable_get(:class)
  end

  def combined_classes
    base = "inline-flex items-center justify-center rounded-md p-2 hover:bg-muted transition-colors cursor-pointer"
    [base, @class].compact.join(" ")
  end
end
