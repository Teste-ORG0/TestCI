number = rand(0..10)
puts "new version"
if number > 7
  puts "❌ Falha!"
  exit(1)
else
  puts "✅ Sucesso!"
  exit(0)
end
