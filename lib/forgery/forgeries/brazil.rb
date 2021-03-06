class Forgery::Brazil < Forgery

  def self.valid_cpf
    cpf = ("%09d" % next_unique_cpf_prefix)
    # ----------------------------------------------------
    # CPF first digit calculation
    first_digit = calculate_digit(sum_cpf_digits(10, 2, cpf))
    # ----------------------------------------------------

    # ----------------------------------------------------
    # CPF second digit calculation
    second_digit = calculate_digit(sum_cpf_digits(11, 3, cpf) + first_digit * 2)
    # ----------------------------------------------------

    cpf += first_digit.to_s + second_digit.to_s
  end

 def self.valid_rg
    @@rg += 1
    @@rg = 0 if @@rg == 9999999999
    @@rg += 1 if((@@rg % 1111111111) == 0)
    ("%010d" % @@rg)
  end

  private
  
  @@cpf_prefix = 0
  @@rg = 0

  def self.next_unique_cpf_prefix
    @@cpf_prefix = 0 if @@cpf_prefix == 999999999
    @@cpf_prefix += 1
  end

  def self.sum_cpf_digits(highest, lowest, cpf)
    digit_sum = 0
    highest.downto lowest do |i|
      digit_sum += cpf[highest-i, 1].to_i * i
    end
    digit_sum
  end

  def self.calculate_digit(sum)
    division_rest = sum % 11
    division_rest < 2 ? 0 : 11 - division_rest
  end

end
