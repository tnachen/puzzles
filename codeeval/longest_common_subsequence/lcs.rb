
def findLcs(aWord, bWord)     
  lcs = ''
  return lcs if aWord.empty? || bWord.empty?
  cache = 0.upto(aWord.length).map{Array.new()}
  0.upto(aWord.length) {|ai| cache[ai][0] = 0}
  0.upto(bWord.length) {|bi| cache[0][bi] = 0}

  aWord.split("").each_with_index do |a, ai|
    bWord.split("").each_with_index do |b, bi|
      if a == b then
        cache[ai + 1][bi + 1] = cache[ai][bi] + 1
      else
        cache[ai + 1][bi + 1] = [ cache[ai][bi + 1], cache[ai + 1][bi] ].max
      end
    end
  end

  traceCache(cache, lcs, aWord, aWord.size, bWord.size)
end

def traceCache(cache, lcs, aWord, x, y)
  return lcs if x == 0 || y == 0
  cur = cache[x][y]  
  backX = cache[x - 1][y] || 0
  backY = cache[x][y - 1] || 0
  if cur > backX && cur > backY
    lcs.insert(0, aWord[x - 1].chr)
    return traceCache(cache, lcs, aWord, x - 1, y - 1)
  elsif backX > backY
    return traceCache(cache, lcs, aWord, x - 1, y)
  else
    return traceCache(cache, lcs, aWord, x, y - 1)
  end
end

File.readlines(ARGV[0]).each do |line| 
  next if line.empty?
  aWord, bWord = line.split(";")
  puts findLcs(aWord || '', bWord || '')
end

exit 0
