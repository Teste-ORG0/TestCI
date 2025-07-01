number = rand(0..10)
other_number = rand(11..20)

if number > 7 && other_number < 14
  puts "❌ Falha!"
  exit(1)
else
  puts "✅ Sucesso!"
  exit(0)
end
