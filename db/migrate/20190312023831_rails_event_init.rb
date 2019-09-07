class RailsEventInit < ActiveRecord::Migration[5.0]

  def change
    
    create_table :event_taxons do |t|
      t.references :organ  # For SaaS
      t.string :name
      t.timestamps
    end
    
    create_table :events do |t|
      t.references :organ  # For SaaS
      t.references :event_taxon
      t.string :type
      t.string :title
      t.string :description, limit: 4096
      t.integer :position
      t.decimal :price, precision: 10, scale: 2
      t.integer :event_members_count, default: 0
      t.integer :event_items_count, default: 0
      t.timestamps
    end

    create_table :event_items do |t|
      t.references :event
      t.string :title
      t.references :author
      t.timestamps
    end

    create_table :event_grants do |t|
      t.references :event
      t.string :grant_kind
      t.string :grant_column
      t.jsonb :filter, default: {}
      t.timestamps
    end

    create_table :crowds do |t|
      t.references :organ  # For SaaS
      t.string :name
      t.string :member_type
      t.integer :crowd_members_count, default: 0
      t.timestamps
    end

    create_table :crowd_members do |t|
      t.references :crowd
      t.references :member, polymorphic: true
      t.references :agency
      t.string :state
      t.timestamps
    end

    create_table :event_participants do |t|
      t.references :event
      t.references :participant, polymorphic: true
      t.string :state
      t.integer :score
      t.string :comment, limit: 4096
      t.string :quit_note
      t.string :assigned_status
      t.string :job_id
      t.timestamps
    end

  end

end
