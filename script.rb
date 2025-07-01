number = rand(0..100)

if number > 7
  puts "❌ Falha!"
  exit(1)
elsif number == 100
  puts "✅ Você foi o grande vencedor!"
  exit(0)
elsif number < 4
  puts "✅ Falhou com sucesso!"
  exit(0)
else
  puts "✅ Sucesso!"
  exit(0)
end
