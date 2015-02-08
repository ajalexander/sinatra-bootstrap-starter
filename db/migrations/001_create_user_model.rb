Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id
      String :username, :null => false, :unique => true
      String :email_address, :null => false
      String :password_hash, :null => false
    end
  end
end
