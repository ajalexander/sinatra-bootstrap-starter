puts 'Seeding users...'

User.create(
  username: 'jdoe',
  email_address: 'jdoe@test.com',
  password: 'test')

User.create(
  username: 'alice',
  email_address: 'alice@test.com',
  password: 'test')