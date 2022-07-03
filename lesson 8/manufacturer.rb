# frozen_string_literal: true

module Manufacturer
  def assign_company(name)
    @company = name
    # puts company
  end

  # def company_name
  #  self.company
  # end

  attr_reader :company
end
