class AddExtentions < ActiveRecord::Migration[7.0]
  def change
    enable_extension('pg_trgm') unless extensions.include?('pg_trgm')
    enable_extension('pgcrypto') unless extensions.include?('pgcrypto')
    enable_extension('uuid-ossp') unless extensions.include?('uuid-ossp')
  end
end
