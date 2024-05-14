def z_algorithm(str)
  sizes = [0] * str.size
  sizes[0] = str.size
  i = 1
  j = 0
  while i < str.size
    j += 1 while i + j < str.size && str[i + j] == str[j]
    sizes[i] = j

    if j.zero?
      i += 1
      next
    end

    k = 1
    while i + k < str.size && k + sizes[k] < j
      sizes[i + k] = sizes[k]
      k += 1
    end
    i += k
    j -= k
  end
  return sizes
end
