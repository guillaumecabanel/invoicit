def simulate_sent_and_paid_for(invoice)
  if rand(4) == 0
    date = Faker::Date.backward(100)
    invoice.update(sent_at: date)
    if rand(2) == 0
      invoice.update(paid_at: Faker::Date.between(date, Date.today))
    end
  end
end

print 'Cleaning database...'
User.destroy_all
puts 'OK'

print 'Create user...'
user = User.create!(
  email:          'user@example.com',
  password:       'password',
  first_name:     Faker::Name.first_name,
  last_name:      Faker::Name.last_name,
  company_name:   Faker::Company.name,
  phone_number:   "0#{Faker::Number.between(1, 7)}#{Faker::Number.number(8)}",
  company_street: Faker::Address.street_name,
  company_postal_code: Faker::Address.postcode,
  company_city:   Faker::Address.city,
  company_siret:  Faker::Number.number(12),
  company_rcs:    Faker::Number.number(10)
)

BankAccountStatement.create!(
  user:           user,
  bank_code:      Faker::Number.number(4),
  counter_number: Faker::Number.number(4),
  account_number: Faker::Number.number(10),
  key:            Faker::Number.number(2),
  currency:       'EUR',
  bank_address:   Faker::Bank.name,
  iban:           Faker::Number.number(12),
  bic:            Faker::Bank.swift_bic
)
puts '......OK'

print 'Create companies...'
5.times do
  user.companies.create!(
    title:                Faker::Company.name,
    address_street:       Faker::Address.street_address,
    address_postal_code:  Faker::Address.postcode,
    address_city:         Faker::Address.city,
    contact_first_name:   Faker::Name.first_name,
    contact_last_name:    Faker::Name.last_name,
    contact_email:        Faker::Internet.safe_email,
    contact_phone_number: "0#{Faker::Number.between(1, 7)}#{Faker::Number.number(8)}"
  )
end
puts '.OK'

print 'Create invoices...'
20.times do
  invoice = Invoice.create!(
    company: Company.order("RANDOM()").first,
    title:   Faker::Company.catch_phrase
  )
  rand(1..6).times do
    invoice.tasks.create!(
      title:            Faker::Company.catch_phrase,
      quantity:         rand(1..11),
      unit_price_cents: rand(50..400) * 100
    )
  end
  EmailMessage.create(
    invoice: invoice,
    subject: "Facture #{invoice.id_code}",
    content:  "Bonjour #{invoice.company.contact_first_name},\n" \
              "En pièce jointe, la facture #{invoice.id_code}.\n" \
              "\nBonne journée,\n" \
              "#{invoice.company.user.first_name}"
  )
  invoice.save!
  simulate_sent_and_paid_for(invoice)
end
puts '..OK'

puts 'Database has been seeded :)'
