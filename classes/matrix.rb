class Matrix
  def compact
    @rows = @rows.reject { |r| r.all?(&:zero?) }
    @rows = @rows.transpose.reject { |r| r.all?(&:zero?) }.transpose
    self
  end

  def binary
    @rows = @rows.map do |row|
      row.map do |el|
        el.zero? ? 0 : 1
      end
    end
  end
end
