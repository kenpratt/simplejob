class Hash

  def truncated_inspect(length = 256)
    values = self.collect do |key, value|
      "#{key.inspect} => #{truncated_value(value, length)}"
    end
    "{#{values.join(', ')}}"
  end

  private

  def truncated_value(value, length)
    value.is_a?(String) && value.length > length ? (value[0 .. length - 3] + "...").inspect : value.inspect
  end
end
